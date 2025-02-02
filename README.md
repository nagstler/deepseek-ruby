# Deepseek Ruby SDK

[![Gem Version](https://badge.fury.io/rb/deepseek.svg)](https://badge.fury.io/rb/deepseek)
[![Build Status](https://github.com/yourusername/deepseek-ruby/workflows/CI/badge.svg)](https://github.com/yourusername/deepseek-ruby/actions)
[![Documentation](https://img.shields.io/badge/docs-yard-blue.svg)](https://rubydoc.info/gems/deepseek)

A comprehensive Ruby SDK for interacting with Deepseek AI APIs. This SDK provides a simple and intuitive interface for accessing Deepseek's powerful AI capabilities.

## Features

- Easy-to-use interface for all Deepseek API endpoints
- Automatic retries with exponential backoff
- Comprehensive error handling
- Thread-safe configuration
- Detailed documentation and examples
- Robust test coverage

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'deepseek'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install deepseek
```

## Configuration

```ruby
Deepseek.configure do |config|
  config.api_key = 'your_api_key'
  config.timeout = 30  # Optional: Set timeout in seconds
  config.max_retries = 3  # Optional: Set max retry attempts
end
```

Or configure with environment variables:

```bash
export DEEPSEEK_API_KEY='your_api_key'
```

## Usage

### Basic Example

```ruby
require 'deepseek'

# Initialize client
client = Deepseek::Client.new(api_key: 'your_api_key')

# Make a chat completion request
response = client.chat_completion(
  messages: [
    { role: 'user', content: 'What is artificial intelligence?' }
  ],
  model: 'deepseek-chat',
  temperature: 0.7
)

puts response.message.content
```

### Handling Responses

```ruby
begin
  response = client.chat_completion(messages: messages)
  puts response.message.content
rescue Deepseek::Error => e
  puts "Error: #{e.message}"
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

### Running Tests

```bash
bundle exec rspec
```

### Generate Documentation

```bash
bundle exec yard
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b feature/my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin feature/my-new-feature`)
5. Create a new Pull Request

## License

This gem is available as open source under the terms of the MIT License.

## Code of Conduct

Everyone interacting in the Deepseek project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](CODE_OF_CONDUCT.md).