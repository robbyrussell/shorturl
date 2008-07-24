# shorturl.rb
#
#   Created by Vincent Foley on 2005-06-02
#

require "net/http"
require "cgi"
require "uri"

class InvalidService < Exception
end

class Service
  attr_accessor :port, :code, :method, :action, :field, :block

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
    @block = lambda { |body| }

    if block_given?
      yield self
    end
  end

  # Now that our service is set up, call it with all the parameters to
  # (hopefully) return only the shortened URL.
  def call(url)
    Net::HTTP.start(@hostname, @port) { |http|
      response = case @method
                 when :post: http.post(@action, "#{@field}=#{url}")
                 when :get: http.get("#{@action}?#{@field}=#{CGI.escape(url)}")
                 end
      if response.code == @code.to_s
        @block.call(response.read_body)
      end
    }
  end
end

class ShortURL
  # Hash table of all the supported services.  The key is a symbol
  # representing the service (usually the hostname minus the .com,
  # .net, etc.)  The value is an instance of Service with all the
  # parameters set so that when +instance+.call is invoked, the
  # shortened URL is returned.
  @@services = {
    :rubyurl => Service.new("rubyurl.com") { |s|
      s.action = "/rubyurl/remote"
      s.field = "website_url"
      s.block = lambda { |body| URI.extract(body).grep(/rubyurl/)[0] }      
    },
    
    :tinyurl => Service.new("tinyurl.com") { |s|
      s.action = "/create.php"
      s.block = lambda { |body| URI.extract(body).grep(/tinyurl/)[-1] }
    },
    
    :shorl => Service.new("shorl.com") { |s|
      s.action = "/create.php"
      s.block = lambda { |body| URI.extract(body)[2] }
    },

    :snipurl => Service.new("snipurl.com") { |s|
      s.action = "/index.php"
      s.field = "link"
      s.block = lambda { |body|
        line = body.split("\n").grep(/txt/)[0]
        short_url = URI.extract(line)[1][0..-2] # Remove trailing '
      }
    },

    :metamark => Service.new("metamark.net") { |s|
      s.action = "/add"
      s.field = "long_url"
      s.block = lambda { |body| URI.extract(body).grep(/xrl.us/)[0] }
    },

    :makeashorterlink => Service.new("makeashorterlink.com") { |s|
      s.action = "/index.php"
      s.block = lambda { |body| URI.extract(body).grep(/makeashorterlink/)[0] }
    },

    :skinnylink => Service.new("skinnylink.com") { |s|
      s.block = lambda { |body| URI.extract(body).grep(/skinnylink/)[0] }
    },

    :linktrim => Service.new("linktrim.com") { |s|
      s.method = :get
      s.action = "/lt/generate"
      s.block = lambda { |body| URI.extract(body).grep(/\/linktrim/)[1] }
    },

    :shorterlink => Service.new("shorterlink.com") { |s|
      s.method = :get
      s.action = "/add_url.html"
      s.block = lambda { |body| URI.extract(body).grep(/shorterlink/)[0] }
    },

    :minilink => Service.new("minilink.org") { |s|
      s.method = :get
      s.block = lambda { |body| URI.extract(body)[-1] }
    },

    :lns => Service.new("ln-s.net") { |s|
      s.method = :get
      s.action = "/home/api.jsp"
      s.block = lambda { |body| URI.extract(body)[0] }
    },

    :fyad => Service.new("fyad.org") { |s|
      s.method = :get
      s.block = lambda { |body| URI.extract(body).grep(/fyad.org/)[2] }
    },

    :d62 => Service.new("d62.net") { |s|
      s.method = :get
      s.block = lambda { |body| URI.extract(body)[0] }
    },

    :shiturl => Service.new("shiturl.com") { |s|
      s.method = :get
      s.action = "/make.php"
      s.block = lambda { |body| URI.extract(body).grep(/shiturl/)[0] }
    },

    :littlink => Service.new("littlink.com") { |s|
      s.block = lambda { |body| URI.extract(body).grep(/littlink/)[0] }
    },

    :clipurl => Service.new("clipurl.com") { |s|
      s.action = "/create.asp"
      s.block = lambda { |body| URI.extract(body).grep(/clipurl/)[0] }
    },

    :shortify => Service.new("shortify.com") { |s|
      s.method = :get
      s.action = "/shorten.php"
      s.block = lambda { |body| URI.extract(body).grep(/shortify/)[0] }
    },

    :orz => Service.new("0rz.net") { |s|
      s.action = "/create.php"
      s.block = lambda { |body| URI.extract(body).grep(/0rz/)[0] }
    },
    
    :moourl => Service.new("moourl.com") { |s|      
      s.code = 302
      s.action = "/create/"
      s.method = :get      
      s.field = "source"
      s.block = lambda { |body| body.gsub('Location/woot/?moo=','http://moourl.com/') } 
    },
    
    :urltea => Service.new("urltea.com") { |s| 
      s.method = :get
      s.action = "/create/"
      s.block = lambda { |body| URI.extract(body).grep(/urltea/)[6] }       
    }
  }

  # Array containing symbols representing all the implemented URL
  # shortening services
  @@valid_services = @@services.keys

  # Returns @@valid_services
  def self.valid_services
    @@valid_services
  end

  # Main method of ShortURL, its usage is quite simple, just give an
  # url to shorten and an optional service.  If no service is
  # selected, RubyURL.com will be used.  An invalid service symbol
  # will raise an ArgumentError exception
  #
  # Valid +service+ values:
  #
  # * <tt>:rubyurl</tt>
  # * <tt>:tinyurl</tt>
  # * <tt>:shorl</tt>
  # * <tt>:snipurl</tt>
  # * <tt>:metamark</tt>
  # * <tt>:makeashorterlink</tt>
  # * <tt>:skinnylink</tt>
  # * <tt>:linktrim</tt>
  # * <tt>:shorterlink</tt>
  # * <tt>:minlink</tt>
  # * <tt>:lns</tt>
  # * <tt>:fyad</tt>
  # * <tt>:d62</tt>
  # * <tt>:shiturl</tt>
  # * <tt>:littlink</tt>
  # * <tt>:clipurl</tt>
  # * <tt>:shortify</tt>
  # * <tt>:orz</tt>
  #
  # call-seq:
  #   ShortURL.shorten("http://mypage.com") => Uses RubyURL
  #   ShortURL.shorten("http://mypage.com", :tinyurl)
  def self.shorten(url, service = :rubyurl)
    if valid_services.include? service
      @@services[service].call(url)
    else
      raise InvalidService
    end
  end
end
