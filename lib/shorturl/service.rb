require "shorturl/exceptions"
require "net/http"
require "net/https"
require "cgi"

module ShortURL
  class Service

    attr_reader :hostname

    attr_accessor :port, :code, :method, :action, :field, :block, :response_block, :ssl

    # Intialize the service with a hostname (required parameter) and you
    # can override the default values for the HTTP port, expected HTTP
    # return code, the form method to use, the form action, the form
    # field which contains the long URL, and the block of what to do
    # with the HTML code you get.
    def initialize(hostname) # :yield: service
      @hostname = hostname
      @port = 80
      @code = 200
      @method = :post
      @action = "/"
      @field = "url"
      @ssl = false

      if block_given?
        yield self
      end
    end

    # Now that our service is set up, call it with all the parameters to
    # (hopefully) return only the shortened URL.
    def call(url)
      http = Net::HTTP.new(@hostname, @port)
      http.use_ssl = @ssl
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      http.start do
        response = case @method
                   when :post
                     http.post(@action, "#{@field}=#{CGI.escape(url)}")
                   when :get
                     http.get("#{@action}?#{@field}=#{CGI.escape(url)}")
                   end

        if response.code == @code.to_s
          on_response(response)
        end
      end
    rescue Errno::ECONNRESET => e
      raise ServiceNotAvailable, e.to_s, e.backtrace
    end

    # Extracts the shortened URL from a response body.
    def on_body(body)
      body
    end

    # Extracts the shortened URL from the response.
    def on_response(response)
      on_body(response.read_body)
    end

  end
end
