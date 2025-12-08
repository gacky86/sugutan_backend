class Gemini::Flash::GenerateContent::Sentence
  def initialize(system_instruction:, text:)
    @system_instruction = system_instruction
    @text = text
  end

  def run
    http_request = prepare_http_request
    http_request[:request].body = request_body
    response = http_request[:http].request(http_request[:request])

    raise 'Gemini: response is not success' unless response.is_a?(Net::HTTPSuccess)

    parsed_response = JSON.parse(response.body)
    text_content = parsed_response.dig('candidates', 0, 'content', 'parts', 0, 'text')
    json = JSON.parse(text_content).symbolize_keys

    json[:response]
    # ActiveRecord::Type::Boolean.new.cast(json[:response])
  end

  private

  def prepare_http_request
    endpoint = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent"
    url = URI.parse("#{endpoint}?key=#{ENV.fetch('GEMINI_API_KEY', nil)}")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(url, { 'Content-Type' => 'application/json' })
    { http: http, request: request }
  end

  def request_body
    {
      contents: [{
        parts: [{
          text: @text
        }],
        role: 'user'
      }],
      systemInstruction: {
        parts: [{
          text: @system_instruction
        }],
        role: 'model'
      },
      generationConfig: {
        responseMimeType: 'application/json',
        responseSchema: {
          type: 'object',
          properties: {
            response: {
              type: 'string'
            }
          }
        }
      }
    }.to_json
  end
end
