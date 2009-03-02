# tc_shortcut.rb
#
#   Created by Vincent Foley on 2005-06-01

$test_lib_dir = File.join(File.dirname(__FILE__), "..", "lib")
$:.unshift($test_lib_dir)

require "test/unit"
require "shorturl"

class String
  def url?
    self[0..6].downcase == "http://"
  end
end

class TestShortURL < Test::Unit::TestCase
  def setup
    @url = "http://groups.google.com/group/comp.lang.ruby/"
  end
  
  def test_shorten
    # Default service (RubyURL)
    assert ShortURL.shorten(@url).url?

    # All the services (I can't test exact URLs since they seem to
    # # change semi regularly)
    # ShortURL.valid_services.each do |service|
    #   assert ShortURL.shorten(@url, service).url?
    # end
    
    # An invalid service
    assert_raise(InvalidService) { ShortURL.shorten(@url, :foobar) }
  end
end
