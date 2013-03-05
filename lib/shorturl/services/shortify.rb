require "shorturl/service"

module ShortURL
  module Services
    class Shortify < Service

      def initialize
        super("shortify.wikinote.com")

        @method = :get
        @action = "/shorten.php"
      end

      def on_body(body)
        URI.extract(body).grep(/shortify/)[-1]
      end

    end
  end
end
