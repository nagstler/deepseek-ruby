require 'simplecov'
require 'simplecov-cobertura'

# Configure SimpleCov
SimpleCov.start do
  add_filter '/spec/'
  add_filter '/vendor/'
  
  enable_coverage :branch
  
  # Add groups for better organization
  add_group 'Client', 'lib/deepseek/client.rb'
  add_group 'Configuration', 'lib/deepseek/configuration.rb'
  add_group 'Errors', 'lib/deepseek/errors.rb'
  
  track_files 'lib/**/*.rb'
end

# Set formatter for CodeClimate
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::CoberturaFormatter
])

require 'deepseek'
require 'webmock/rspec'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.order = :random
  config.example_status_persistence_file_path = "spec/examples.txt"
  
  config.before(:each) do
    WebMock.disable_net_connect!
  end

  config.after(:each) do
    WebMock.reset!
  end
end