require "shorturl/service"

module ShortURL
  module Services
    class Bitly < Service

      def initialize
        super("api-ssl.bitly.com")

        @method = :get
        @port = 443
        @ssl = true
        @action = "/v3/shorten/"

        creds = ShortURL.credentials_for('bitly')
        username = creds['username'] 
        key = creds['key'] 

        @field = "format=txt&login=#{username}&apiKey=#{key}&longUrl"
      end

      def on_body(body)
        body
      end

    end
  end
end
