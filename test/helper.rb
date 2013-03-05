require 'rubygems'
require 'test/unit'

class Test::Unit::TestCase

  def assert_url(url)
    assert url[0..6].downcase == "http://"
  end

end
