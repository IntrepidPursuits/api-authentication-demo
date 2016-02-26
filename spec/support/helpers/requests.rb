module Helpers
  module Requests
    def body
      response.body
    end

    def json_value_at_path(path = '')
      parse_json(body, path)
    end

    def api_version
      1
    end

    def accept_header
      "application/vnd.authentication-demo-app.com; version=#{api_version}"
    end

    def accept_headers
      { 'Accept' => accept_header,
        'Content-Type' => 'application/json' }
    end
  end
end
