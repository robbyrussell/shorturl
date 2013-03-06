require 'spec_helper'
require 'services/examples'
require 'shorturl/services/tinyurl'

describe Services::TinyURL do
  its(:hostname) { should == 'tinyurl.com'     }
  its(:method)   { should == :get              }
  its(:action)   { should == '/api-create.php' }

  let(:url)      { "http://www.google.com/" }
  let(:shorturl) { "http://tinyurl.com/161" }

  include_context "Services"
end
