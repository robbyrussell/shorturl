require 'shorturl/service'

module ShortURL
  module Services
    class TinyURL < Service

      def initialize
        super('tinyurl.com')

        @action = "/api-create.php"
        @method = :get
      end

      def on_body(body)
        URI.extract(body).grep(/tinyurl/)[0]
      end

    end
  end
end
