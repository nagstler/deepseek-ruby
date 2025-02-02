RSpec.describe Deepseek::Client do
  let(:api_key) { 'test-key' }
  let(:client) { described_class.new(api_key: api_key) }
  let(:base_url) { 'https://api.deepseek.com' }
  let(:messages) { [{ role: 'user', content: 'Hello' }] }
  let(:headers) do
    {
      'Authorization' => "Bearer #{api_key}",
      'Content-Type' => 'application/json',
      'Accept' => 'application/json',
      'User-Agent' => "deepseek-ruby/#{Deepseek::VERSION}"
    }
  end

  describe '#initialize' do
    before do
      ENV['DEEPSEEK_API_KEY'] = nil
    end

    it 'creates a client with an API key' do
      expect(client.config.api_key).to eq(api_key)
    end

    it 'raises an error without an API key' do
      expect { 
        described_class.new 
      }.to raise_error(Deepseek::ConfigurationError, 'API key must be set')
    end

    it 'accepts configuration options' do
      client = described_class.new(api_key: api_key, timeout: 60)
      expect(client.config.timeout).to eq(60)
    end
  end

  describe '#chat' do
    let(:endpoint) { "#{base_url}/v1/chat/completions" }
    let(:request_body) { { model: 'deepseek-chat', messages: messages } }

    context 'with successful response' do
      before do
        stub_request(:post, endpoint)
          .with(
            body: request_body,
            headers: headers
          )
          .to_return(
            status: 200,
            headers: { 'Content-Type' => 'application/json' },
            body: { choices: [{ message: { content: 'Hi there!' } }] }.to_json
          )
      end

      it 'makes a successful API call' do
        response = client.chat(messages: messages)
        expect(response['choices'][0]['message']['content']).to eq('Hi there!')
      end
    end

    context 'with API errors' do
      it 'handles authentication errors' do
        stub_request(:post, endpoint)
          .with(
            body: request_body,
            headers: headers
          )
          .to_return(
            status: 401,
            headers: { 'Content-Type' => 'application/json' },
            body: { error: { message: 'Invalid API key' } }.to_json
          )

        expect { 
          client.chat(messages: messages)
        }.to raise_error(Deepseek::AuthenticationError, /Invalid API key/)
      end

      it 'handles rate limit errors' do
        stub_request(:post, endpoint)
          .with(
            body: request_body,
            headers: headers
          )
          .to_return(
            status: 429,
            headers: { 'Content-Type' => 'application/json' },
            body: { error: { message: 'Rate limit exceeded' } }.to_json
          )

        expect { 
          client.chat(messages: messages)
        }.to raise_error(Deepseek::RateLimitError, /Rate limit exceeded/)
      end

      it 'handles invalid requests' do
        stub_request(:post, endpoint)
          .with(
            body: request_body,
            headers: headers
          )
          .to_return(
            status: 400,
            headers: { 'Content-Type' => 'application/json' },
            body: { error: { message: 'Invalid request parameters' } }.to_json
          )

        expect { 
          client.chat(messages: messages)
        }.to raise_error(Deepseek::InvalidRequestError, /Invalid request parameters/)
      end
    end
  end
end