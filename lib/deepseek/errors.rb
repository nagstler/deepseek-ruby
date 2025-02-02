module Deepseek
    class Error < StandardError; end
    
    class ConfigurationError < Error; end
    
    class APIError < Error
      attr_reader :code, :response
  
      def initialize(message = nil, code: nil, response: nil)
        @code = code
        @response = response
        super(message)
      end
    end
  
    class AuthenticationError < APIError; end
    class RateLimitError < APIError; end
    class InvalidRequestError < APIError; end
    class APIConnectionError < APIError; end
    class ServiceUnavailableError < APIError; end
  end