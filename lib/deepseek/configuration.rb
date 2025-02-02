module Deepseek
    class Configuration
      attr_accessor :api_key, :api_base_url, :timeout, :max_retries
  
      def initialize
        @api_key = ENV['DEEPSEEK_API_KEY']
        @api_base_url = ENV['DEEPSEEK_API_BASE_URL'] || 'https://api.deepseek.com/v1'
        @timeout = ENV['DEEPSEEK_TIMEOUT']&.to_i || 30
        @max_retries = ENV['DEEPSEEK_MAX_RETRIES']&.to_i || 3
      end
  
      def validate!
        raise Deepseek::ConfigurationError, 'API key must be set' if api_key.nil? || api_key.empty?
      end
    end
  end