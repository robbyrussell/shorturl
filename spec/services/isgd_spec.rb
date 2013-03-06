require 'spec_helper'
require 'services/examples'
require 'shorturl/services/isgd'

describe Services::Isgd do
  its(:hostname) { should == 'is.gd'    }
  its(:method)   { should == :get       }
  its(:action)   { should == '/api.php' }
  its(:field)    { should == 'longurl'  }

  let(:url)      { "http://www.google.com/" }
  let(:shorturl) { "http://is.gd/9INTbT"    }

  include_context "Services"
end
