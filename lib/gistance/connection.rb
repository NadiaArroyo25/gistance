require 'faraday'
require 'faraday_mashify'
require 'faraday-follow_redirects'

module Gistance
  # Faraday connection methods
  module Connection
    private

    def connection
      options = {
        ssl: { verify: false },
        url: self.api_endpoint
      }

      connection = Faraday.new(options) do |conn|

        conn.request :json
        conn.response :json, content_type: /\bjson$/

        conn.use Gistance::Response::RaiseError
        conn.use FaradayMiddleware::FollowRedirects, limit: 3

        conn.adapter Faraday.default_adapter
      end

      connection
    end
  end
end
