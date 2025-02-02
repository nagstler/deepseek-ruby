require 'spec_helper'

RSpec.describe Deepseek::Client do
  let(:api_key) { 'test_key' }
  let(:client) { described_class.new(api_key: api_key) }

  describe '#initialize' do
    it 'creates a client with an API key' do
      expect(client.config.api_key).to eq(api_key)
    end

    it 'raises an error without an API key' do
      expect { described_class.new }.to raise_error(Deepseek::ConfigurationError)
    end
  end

  describe '#chat' do
    let(:messages) { [{ role: 'user', content: 'Hello' }] }
    let(:response_body) { { choices: [{ message: { content: 'Hi there!' } }] } }

    before do
      stub_request(:post, "#{client.config.api_base_url}/chat/completions")
        .with(
          body: { model: 'deepseek-chat', messages: messages },
          headers: { 'Authorization' => "Bearer #{api_key}" }
        )
        .to_return(status: 200, body: response_body.to_json)
    end

    it 'makes a successful API call' do
      response = client.chat(messages: messages)
      expect(response['choices'].first['message']['content']).to eq('Hi there!')
    end
  end

  describe 'error handling' do
    it 'handles authentication errors' do
      stub_request(:post, "#{client.config.api_base_url}/chat/completions")
        .to_return(status: 401, body: { error: { message: 'Invalid API key' } }.to_json)

      expect { 
        client.chat(messages: [{ role: 'user', content: 'Hello' }])
      }.to raise_error(Deepseek::AuthenticationError)
    end

    it 'handles rate limit errors' do
      stub_request(:post, "#{client.config.api_base_url}/chat/completions")
        .to_return(status: 429, body: { error: { message: 'Rate limit exceeded' } }.to_json)

      expect { 
        client.chat(messages: [{ role: 'user', content: 'Hello' }])
      }.to raise_error(Deepseek::RateLimitError)
    end
  end
end