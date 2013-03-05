require "shorturl/service"

module ShortURL
  module Services
    class Shorl < Service

      def initialize
        super("shorl.com")

        @action = "/create.php"
      end

      def on_body(body)
        URI.extract(body)[2]
      end

    end
  end
end
