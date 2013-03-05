require "shorturl/service"

module ShortURL
  module Services
    class ShitURL < Service

      def initialize
        super("shiturl.com")

        @method = :get
        @action = "/make.php"
      end

      def on_body(body)
        URI.extract(body).grep(/shiturl/)[0]
      end

    end
  end
end
