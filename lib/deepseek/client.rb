require 'faraday'
require 'faraday/retry'
require 'json'

module Deepseek
  class Client
    attr_reader :config

    def initialize(api_key: nil, **options)
      @config = Configuration.new
      @config.api_key = api_key if api_key
      options.each do |key, value|
        @config.send("#{key}=", value) if @config.respond_to?("#{key}=")
      end
      @config.validate!
    end

    def chat(messages:, model: 'deepseek-chat', **params)
      post('/v1/chat/completions', {
        model: model,
        messages: messages,
        **params
      })
    rescue Faraday::Error => e
      handle_error_response(e.response) if e.response
      raise e
    end

    private

    def connection
      @connection ||= Faraday.new(url: config.api_base_url) do |faraday|
        faraday.request :json
        
        faraday.request :retry, {
          max: config.max_retries,
          interval: 0.5,
          interval_randomness: 0.5,
          backoff_factor: 2,
          exceptions: [
            Faraday::ConnectionFailed,
            Faraday::TimeoutError,
            'Timeout::Error',
            'Error::TimeoutError'
          ]
        }

        # Don't automatically raise errors, we want to handle them ourselves
        faraday.response :raise_error

        faraday.adapter Faraday.default_adapter
        faraday.options.timeout = config.timeout
      end
    end

    def handle_error_response(response)
      status = response[:status]
      error_info = parse_error_response(response[:body])

      case status
      when 401
        raise AuthenticationError.new(error_info[:message], code: status, response: response)
      when 429
        raise RateLimitError.new(error_info[:message], code: status, response: response)
      when 400, 404
        raise InvalidRequestError.new(error_info[:message], code: status, response: response)
      when 500..599
        raise ServiceUnavailableError.new("Service error: #{status}", code: status, response: response)
      else
        raise APIError.new("Unknown error: #{status}", code: status, response: response)
      end
    end

    def parse_error_response(body)
      return { message: body } unless body.is_a?(String)
      
      parsed = JSON.parse(body, symbolize_names: true)
      {
        message: parsed.dig(:error, :message) || parsed[:message] || "Unknown error",
        code: parsed.dig(:error, :code) || parsed[:code]
      }
    rescue JSON::ParserError
      { message: body }
    end

    def request_headers
      {
        'Authorization' => "Bearer #{config.api_key}",
        'Content-Type' => 'application/json',
        'Accept' => 'application/json',
        'User-Agent' => "deepseek-ruby/#{VERSION}"
      }
    end

    def post(endpoint, body = {})
      response = connection.post(endpoint) do |req|
        req.headers = request_headers
        req.body = body
      end

      case response.status
      when 200..299
        JSON.parse(response.body)
      else
        handle_error_response(
          status: response.status,
          body: response.body,
          headers: response.headers,
          request: {
            method: 'POST',
            url: response.env.url.to_s,
            headers: response.env.request_headers,
            body: body
          }
        )
      end
    rescue JSON::ParserError
      raise APIError.new("Invalid JSON response", response: response)
    end
  end
end