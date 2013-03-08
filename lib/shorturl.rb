# shorturl.rb
#
#   Created by Vincent Foley on 2005-06-02
#

require "shorturl/services"
require "uri"
require "yaml"

module ShortURL
  CREDENTIALS_PATH = File.join(Gem.user_home,'.shorturl')

  def self.credentials
    @credentials ||= begin
                       if File.file?(CREDENTIALS_PATH)
                         YAML.load_file(CREDENTIALS_PATH)
                       else
                         {}
                       end
                     end
  end

  def self.credentials_for(service)
    credentials.fetch(service,{})
  end

  # Hash table of all the supported services.  The key is a symbol
  # representing the service (usually the hostname minus the .com,
  # .net, etc.)  The value is an instance of Service with all the
  # parameters set so that when +instance+.call is invoked, the
  # shortened URL is returned.
  SERVICES = {
    :tinyurl => Services::TinyURL.new,
    :shorl => Services::Shorl.new,
    :snipurl => Services::SnipURL.new,
    :metamark => Services::Metamark.new,
    :minilink => Services::Minilink.new,
    :lns => Services::Lns.new,
    :shiturl => Services::ShitURL.new,
    :shortify => Services::Shortify.new,
    :moourl => Services::MooURL.new,
    :bitly => Services::Bitly.new,
    :ur1 => Services::Url.new,
    :vurl => Services::Vurl.new,
    :isgd => Services::Isgd.new,
    :gitio => Services::Gitio.new,
    :vamu => Services::Vamu.new,

    # :skinnylink => Service.new("skinnylink.com") { |s|
    #   s.block = lambda { |body| URI.extract(body).grep(/skinnylink/)[0] }
    # },

    # :linktrim => Service.new("linktrim.com") { |s|
    #   s.method = :get
    #   s.action = "/lt/generate"
    #   s.block = lambda { |body| URI.extract(body).grep(/\/linktrim/)[1] }
    # },

    # :shorterlink => Service.new("shorterlink.com") { |s|
    #   s.method = :get
    #   s.action = "/add_url.html"
    #   s.block = lambda { |body| URI.extract(body).grep(/shorterlink/)[0] }
    # },

    # :fyad => Service.new("fyad.org") { |s|
    #   s.method = :get
    #   s.block = lambda { |body| URI.extract(body).grep(/fyad.org/)[2] }
    # },

    # :d62 => Service.new("d62.net") { |s|
    #   s.method = :get
    #   s.block = lambda { |body| URI.extract(body)[0] }
    # },

    # :littlink => Service.new("littlink.com") { |s|
    #   s.block = lambda { |body| URI.extract(body).grep(/littlink/)[0] }
    # },

    # :clipurl => Service.new("clipurl.com") { |s|
    #   s.action = "/create.asp"
    #   s.block = lambda { |body| URI.extract(body).grep(/clipurl/)[0] }
    # },

    # :orz => Service.new("0rz.net") { |s|
    #   s.action = "/create.php"
    #   s.block = lambda { |body| URI.extract(body).grep(/0rz/)[0] }
    # },

    # :urltea => Service.new("urltea.com") { |s|
    #   s.method = :get
    #   s.action = "/create/"
    #   s.block = lambda { |body| URI.extract(body).grep(/urltea/)[6] }
    # }
  }

  # Array containing symbols representing all the implemented URL
  # shortening services
  def self.valid_services
    SERVICES.keys
  end

  # Main method of ShortURL, its usage is quite simple, just give an
  # url to shorten and an optional service.  If no service is
  # selected, RubyURL.com will be used.  An invalid service symbol
  # will raise an ArgumentError exception
  #
  # Valid +service+ values:
  #
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
  # * <tt>:isgd</tt>
  # * <tt>:gitio</tt>
  # * <tt>:vamu</tt>
  #
  # call-seq:
  #   ShortURL.shorten("http://mypage.com") => Uses TinyURL
  #   ShortURL.shorten("http://mypage.com", :bitly)
  def self.shorten(url, service = :tinyurl)
    if SERVICES.has_key?(service)
      SERVICES[service].call(url)
    else
      raise InvalidService
    end
  end
end
