require "shorturl/service"

module ShortURL
  module Services
    class MooURL < Service

      def initialize
        super("moourl.com")

        @code = 302
        @method = :get
        @action = "/create/"
        @field = "source"
      end

      def on_response(response)
        "http://moourl.com/" + res["location"].match(/\?moo=/).post_match
      end

    end
  end
end
