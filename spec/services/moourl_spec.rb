require 'spec_helper'
require 'services/examples'
require 'shorturl/services/moourl'

describe Services::MooURL do
  its(:hostname) { should == 'moourl.com' }
  its(:method)   { should == :get         }
  its(:action)   { should == '/create/'   }
  its(:field)    { should == 'source'     }

  let(:url)      { "http://www.google.com/"  }
  let(:shorturl) { "http://moourl.com/ad8vt" }

  include_context "Services"
end
