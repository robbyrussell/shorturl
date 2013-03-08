require 'spec_helper'
require 'services/examples'
require 'shorturl/services/snipurl'

describe Services::SnipURL do
  its(:hostname) { should == 'snipurl.com' }
  its(:action)   { should == '/site/index' }
  its(:field)    { should == 'url'         }

  let(:url)      { "http://www.google.com/"     }
  let(:shorturl) { "http://snipurl.com/26jjd3f" }

  include_context "Services"
end
