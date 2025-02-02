require 'faraday'
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

    # Chat Completion endpoint
    def chat(messages:, model: 'deepseek-chat', **params)
      post('/chat/completions', {
        model: model,
        messages: messages,
        **params
      })
    end

    # Text Completion endpoint
    def complete(prompt:, model: 'deepseek-text', **params)
      post('/completions', {
        model: model,
        prompt: prompt,
        **params
      })
    end

    # Model information endpoints
    def list_models
      get('/models')
    end

    def retrieve_model(model_id)
      get("/models/#{model_id}")
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
        faraday.response :raise_error
        faraday.adapter Faraday.default_adapter
        faraday.options.timeout = config.timeout
      end
    end

    def handle_response(response)
      case response.status
      when 200..299
        JSON.parse(response.body)
      when 401
        raise AuthenticationError.new("Invalid API key", code: response.status, response: response)
      when 429
        raise RateLimitError.new("Rate limit exceeded", code: response.status, response: response)
      when 400, 404
        raise InvalidRequestError.new(error_message_from_response(response), code: response.status, response: response)
      when 500..599
        raise ServiceUnavailableError.new("Service error: #{response.status}", code: response.status, response: response)
      else
        raise APIError.new("Unknown error: #{response.status}", code: response.status, response: response)
      end
    rescue JSON::ParserError
      raise APIError.new("Invalid JSON response", response: response)
    end

    def error_message_from_response(response)
      return response.body unless response.body.is_a?(String)
      
      begin
        error_data = JSON.parse(response.body)
        error_data['error']['message'] || error_data['message'] || response.body
      rescue JSON::ParserError
        response.body
      end
    end

    def request_headers
      {
        'Authorization' => "Bearer #{config.api_key}",
        'Content-Type' => 'application/json',
        'Accept' => 'application/json',
        'User-Agent' => "deepseek-ruby/#{VERSION}"
      }
    end

    def get(endpoint, params = {})
      response = connection.get(endpoint) do |req|
        req.headers = request_headers
        req.params = params
      end
      handle_response(response)
    end

    def post(endpoint, body = {})
      response = connection.post(endpoint) do |req|
        req.headers = request_headers
        req.body = body.to_json
      end
      handle_response(response)
    end
  end
end