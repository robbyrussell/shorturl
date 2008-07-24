# ts_all.rb
#
#  Created by Vincent Foley on 2005-06-01

$test_lib_dir = File.join(File.dirname(__FILE__))
$:.unshift($test_lib_dir)

require "test/unit"

require "tc_shorturl"
require "tc_service"
