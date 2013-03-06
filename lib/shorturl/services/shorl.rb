require "shorturl/service"

module ShortURL
  module Services
    class Shorl < Service

      def initialize
        super("shorl.com")

        @action = "/create.php"
      end

      def on_body(body)
        URI.extract(body).grep(/http:\/\/shorl\.com\//)[0]
      end

    end
  end
end
