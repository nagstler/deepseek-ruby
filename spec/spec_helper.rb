require 'simplecov'
require 'simplecov-cobertura'

SimpleCov.start do
  enable_coverage :branch
  
  add_filter '/spec/'
  add_filter '/vendor/'
  
  add_group 'Client', 'lib/deepseek/client'
  add_group 'Configuration', 'lib/deepseek/configuration'
  add_group 'Errors', 'lib/deepseek/errors'
end

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::CoberturaFormatter
])

require 'deepseek'
require 'webmock/rspec'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Clean up after each test
  config.after(:each) do
    Deepseek.reset_configuration!
  end

  # Configure WebMock
  config.before(:each) do
    WebMock.disable_net_connect!
  end

  config.after(:each) do
    WebMock.reset!
  end
end