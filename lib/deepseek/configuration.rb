module Deepseek
  class Configuration
    attr_accessor :api_key, :api_base_url, :timeout, :max_retries

    def initialize
      @api_key = ENV['DEEPSEEK_API_KEY']
      @api_base_url = ENV['DEEPSEEK_API_BASE_URL'] || 'https://api.deepseek.com'
      @timeout = ENV['DEEPSEEK_TIMEOUT']&.to_i || 30
      @max_retries = ENV['DEEPSEEK_MAX_RETRIES']&.to_i || 3
      validate! unless api_key.nil? # Don't validate during initialization
    end

    def validate!
      raise ConfigurationError, 'API key must be set' if api_key.nil? || api_key.strip.empty?
    end
  end
end