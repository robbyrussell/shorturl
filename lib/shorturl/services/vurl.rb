require "shorturl/service"

module ShortURL
  module Services
    class Vurl < Service

      def initialize
        super("vurl.me")

        @method = :get
        @action = "/shorten"
        @field  = "url"
      end

    end
  end
end
