require 'spec_helper'
require 'services/examples'
require 'shorturl/services/minilink'

describe Services::Minilink do
  its(:hostname) { should == 'minilink.org'  }
  its(:method)   { should == :get            }

  let(:url)      { "http://www.nasa.gov/images/content/58392main_image_feature_163_jw4.jpg" }
  let(:shorturl) { "http://lnk.nu/nasa.gov/1iok.jpg" }

  include_context "Services"
end
