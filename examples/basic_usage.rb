require 'deepseek'

# Configure the client
Deepseek.configure do |config|
  config.api_key = ENV['DEEPSEEK_API_KEY']
  config.timeout = 60  # Optional: Set custom timeout
end

# Initialize client
client = Deepseek::Client.new

# Simple chat completion
response = client.chat(
  messages: [
    { role: 'user', content: 'What is the capital of France?' }
  ],
  model: 'deepseek-chat'
)

puts "Response: #{response['choices'].first['message']['content']}"

# Chat completion with system message
response = client.chat(
  messages: [
    { role: 'system', content: 'You are a helpful assistant who speaks like Shakespeare.' },
    { role: 'user', content: 'Tell me about artificial intelligence.' }
  ],
  model: 'deepseek-chat',
  temperature: 0.7
)

puts "\nShakespearean AI response: #{response['choices'].first['message']['content']}"

# Error handling example
begin
  client.chat(messages: [{ role: 'user', content: 'Hello' }], model: 'nonexistent-model')
rescue Deepseek::InvalidRequestError => e
  puts "\nError: #{e.message}"
rescue Deepseek::APIError => e
  puts "\nAPI Error: #{e.message}"
end