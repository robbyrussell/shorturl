require 'spec_helper'
require 'services/examples'
require 'shorturl/services/vamu'

describe Services::Vamu do
  its(:hostname) { should == 'va.mu'       }
  its(:action)   { should == '/api/create' }

  let(:url)      { "http://www.google.com/" }
  let(:shorturl) { "http://va.mu/SZ"        }

  include_context "Services"
end
