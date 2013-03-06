require "shorturl/service"

module ShortURL
  module Services
    # SnipURL offers a restful HTTP API but it cannot be used without
    # registration.
    class SnipURL < Service

      def initialize
        super("snipurl.com")

        @action = "/site/index"
        @field = "url"
      end

      def on_body(body)
        URI.extract(body).grep(/http:\/\/snipurl.com/)[9]
      end

    end
  end
end
