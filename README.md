# Deepseek Ruby SDK

<a href="https://badge.fury.io/rb/deepseek"><img src="https://img.shields.io/gem/v/deepseek?style=for-the-badge" alt="Gem Version"></a>
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge" alt="License"></a>
<a href="https://codeclimate.com/github/nagstler/deepseek-ruby/maintainability"><img src="https://img.shields.io/codeclimate/maintainability/nagstler/deepseek-ruby?style=for-the-badge" alt="Maintainability"></a>
<a href="https://codeclimate.com/github/nagstler/deepseek-ruby/test_coverage"><img src="https://img.shields.io/codeclimate/coverage/nagstler/deepseek-ruby?style=for-the-badge" alt="Test Coverage"></a>
<a href="https://github.com/nagstler/deepseek-ruby/actions/workflows/ci.yml"><img src="https://img.shields.io/github/actions/workflow/status/nagstler/deepseek-ruby/ci.yml?branch=main&style=for-the-badge" alt="CI"></a>
<a href="https://github.com/nagstler/deepseek-ruby/stargazers"><img src="https://img.shields.io/github/stars/nagstler/deepseek-ruby?style=for-the-badge" alt="GitHub stars"></a>

A Ruby SDK for interacting with the Deepseek AI API. This SDK provides a simple and intuitive interface for making API calls, handling responses, and managing errors.

## Features

- 🚀 Simple and intuitive interface
- ⚡️ Automatic retries with exponential backoff
- 🛡️ Comprehensive error handling
- ⚙️ Flexible configuration options
- 🔒 Secure API key management
- 📝 Detailed response handling

## Table of Contents

- [Installation](#installation)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
- [API Reference](#api-reference)
- [Usage Examples](#usage-examples)
- [Error Handling](#error-handling)
- [Retry Handling](#retry-handling)
- [Development](#development)
- [Contributing](#contributing)
- [Support](#support)
- [License](#license)

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

## Quick Start

```ruby
require 'deepseek'

# Initialize client
client = Deepseek::Client.new(api_key: 'your-api-key')

# Make a chat completion request
response = client.chat(
  messages: [
    { role: 'user', content: 'What is artificial intelligence?' }
  ],
  model: 'deepseek-chat'
)

puts response['choices'][0]['message']['content']
```

## Configuration

### Basic Configuration

```ruby
client = Deepseek::Client.new(
  api_key: 'your-api-key',
  timeout: 60,      # Custom timeout in seconds
  max_retries: 3    # Number of retries for failed requests
)
```

### Environment Variables

The SDK supports configuration through environment variables:

```bash
DEEPSEEK_API_KEY=your-api-key
DEEPSEEK_API_BASE_URL=https://api.deepseek.com  # Optional
DEEPSEEK_TIMEOUT=30                             # Optional
DEEPSEEK_MAX_RETRIES=3                         # Optional
```

## API Reference

### Available Methods

#### chat(messages:, model: 'deepseek-chat', **params)

Make a chat completion request.

Parameters:
- `messages` (Array, required): Array of message objects
- `model` (String, optional): Model to use, defaults to 'deepseek-chat'
- `temperature` (Float, optional): Sampling temperature

Response Format:
```ruby
{
  "choices" => [{
    "message" => {
      "content" => "Hello! How can I help you today?",
      "role" => "assistant"
    },
    "finish_reason" => "stop"
  }],
  "created" => 1677649420,
  "id" => "chatcmpl-123",
  "model" => "deepseek-chat",
  "usage" => {
    "completion_tokens" => 17,
    "prompt_tokens" => 57,
    "total_tokens" => 74
  }
}
```

## Usage Examples

### Chat with System Message
```ruby
response = client.chat(
  messages: [
    { role: 'system', content: 'You are a friendly AI assistant.' },
    { role: 'user', content: 'Hello!' }
  ],
  temperature: 0.7,
  model: 'deepseek-chat'
)
```

### Conversation with History
```ruby
conversation = [
  { role: 'user', content: 'What is your favorite color?' },
  { role: 'assistant', content: 'I don\'t have personal preferences, but I can discuss colors!' },
  { role: 'user', content: 'Tell me about blue.' }
]

response = client.chat(
  messages: conversation,
  temperature: 0.8
)
```

### Advanced Configuration Example
```ruby
client = Deepseek::Client.new(
  api_key: ENV['DEEPSEEK_API_KEY'],
  timeout: 60,               # Custom timeout
  max_retries: 5,           # Custom retry limit
  api_base_url: 'https://custom.deepseek.api.com'  # Custom API URL
)
```

## Error Handling

The SDK provides comprehensive error handling for various scenarios:

```ruby
begin
  response = client.chat(messages: messages)
rescue Deepseek::AuthenticationError => e
  # Handle authentication errors (e.g., invalid API key)
  puts "Authentication error: #{e.message}"
rescue Deepseek::RateLimitError => e
  # Handle rate limit errors
  puts "Rate limit exceeded: #{e.message}"
rescue Deepseek::InvalidRequestError => e
  # Handle invalid request errors
  puts "Invalid request: #{e.message}"
rescue Deepseek::ServiceUnavailableError => e
  # Handle API service errors
  puts "Service error: #{e.message}"
rescue Deepseek::APIError => e
  # Handle other API errors
  puts "API error: #{e.message}"
end
```

## Retry Handling

The SDK automatically handles retries with exponential backoff for failed requests:

- Automatic retry on network failures
- Exponential backoff strategy
- Configurable max retry attempts
- Retry on rate limits and server errors

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

### Running Tests

```bash
bundle exec rake spec
```

### Running the Console

```bash
bin/console
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nagstler/deepseek-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](CODE_OF_CONDUCT.md).

For detailed contribution guidelines, please see our [Contributing Guide](CONTRIBUTING.md).

## Support

If you discover any issues or have questions, please create an issue on GitHub.

## License

The gem is available as open source under the terms of the MIT License. See [LICENSE.txt](LICENSE.txt) for details.

## Code of Conduct

Everyone interacting in the Deepseek project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](CODE_OF_CONDUCT.md).