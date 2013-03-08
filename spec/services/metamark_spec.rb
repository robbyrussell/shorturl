require 'spec_helper'
require 'services/examples'
require 'shorturl/services/metamark'

describe Services::Metamark do
  its(:hostname) { should == 'metamark.net' }
  its(:action)   { should == '/add'         }
  its(:field)    { should == 'long_url'     }

  let(:url)      { "http://www.google.com/" }
  let(:shorturl) { "http://xrl.us/bnj"      }

  include_context "Services"
end
