require "shorturl/service"

module ShortURL
  module Services
    class Url < Service

      def initialize
        super("url.ca")

        @method = :post
        @action = "/"
        @field = "longurl"
      end

      def on_body(body)
        URI.extract(body).grep(/ur1/)[0]
      end

    end
  end
end
