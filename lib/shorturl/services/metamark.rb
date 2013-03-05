require "shorturl/services/metamark"

module ShortURL
  module Services
    class Metamark < Service

      def initialize
        super("metamark.net")

        @action = "/add"
        @field = "long_url"
      end

      def on_body(body)
        URI.extract(body).grep(/xrl.us/)[0]
      end

    end
  end
end
