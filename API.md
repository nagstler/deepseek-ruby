# Deepseek Ruby SDK API Reference

## Table of Contents

- [Client](#client)
  - [Configuration](#configuration)
  - [Methods](#methods)
- [Error Handling](#error-handling)
- [Response Format](#response-format)

## Client

### Configuration

The `Deepseek::Client` can be configured with the following options:

```ruby
client = Deepseek::Client.new(
  api_key: 'your-api-key',      # Required
  timeout: 30,                  # Optional (default: 30)
  max_retries: 3,              # Optional (default: 3)
  api_base_url: 'custom_url'   # Optional (default: https://api.deepseek.com)
)
```

#### Environment Variables

All configuration options can be set via environment variables:

```bash
DEEPSEEK_API_KEY=your-api-key
DEEPSEEK_TIMEOUT=30
DEEPSEEK_MAX_RETRIES=3
DEEPSEEK_API_BASE_URL=https://api.deepseek.com
```

### Methods

#### chat(messages:, model: 'deepseek-chat', **params)

Make a chat completion request.

```ruby
response = client.chat(
  messages: [
    { role: 'user', content: 'Hello!' }
  ],
  model: 'deepseek-chat',    # Optional
  temperature: 0.7           # Optional
)
```

Parameters:
- `messages` (Array, required): Array of message objects
- `model` (String, optional): Model to use, defaults to 'deepseek-chat'
- `temperature` (Float, optional): Sampling temperature

## Error Handling

The SDK provides several error classes for different types of errors:

### Deepseek::AuthenticationError

Raised when there are authentication issues (e.g., invalid API key).

```ruby
begin
  client.chat(messages: messages)
rescue Deepseek::AuthenticationError => e
  puts "Authentication failed: #{e.message}"
  puts "Status code: #{e.code}"
end
```

### Deepseek::RateLimitError

Raised when you've exceeded the API rate limits.

```ruby
rescue Deepseek::RateLimitError => e
  puts "Rate limit exceeded: #{e.message}"
  puts "Retry after: #{e.response[:headers]['retry-after']}"
end
```

### Deepseek::InvalidRequestError

Raised when the request is malformed or invalid.

```ruby
rescue Deepseek::InvalidRequestError => e
  puts "Invalid request: #{e.message}"
end
```

### Deepseek::ServiceUnavailableError

Raised when the API service is having issues.

```ruby
rescue Deepseek::ServiceUnavailableError => e
  puts "Service unavailable: #{e.message}"
end
```

### Deepseek::APIError

Generic error class for unexpected API errors.

```ruby
rescue Deepseek::APIError => e
  puts "API error: #{e.message}"
end
```

## Response Format

The API returns responses in the following format:

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