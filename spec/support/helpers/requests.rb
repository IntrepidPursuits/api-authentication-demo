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

    def authorization_header(user)
      "Token token=#{user.authentication_token}"
    end

    def authorization_headers(user)
      accept_headers.merge('Authorization' => authorization_header(user))
    end
  end
end
