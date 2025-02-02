require 'faraday'
require 'json'

require_relative 'deepseek/version'
require_relative 'deepseek/configuration'
require_relative 'deepseek/errors'
require_relative 'deepseek/client'

module Deepseek
  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def reset_configuration!
      @configuration = Configuration.new
    end
  end
end