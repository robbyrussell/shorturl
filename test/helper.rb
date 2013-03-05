require 'rubygems'
require 'test/unit'
require 'uri'

class Test::Unit::TestCase

  def assert_url(url)
    assert URI(url).scheme.downcase == "http"
  end

end
