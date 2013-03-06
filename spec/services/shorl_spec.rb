require 'spec_helper'
require 'services/examples'
require 'shorturl/services/shorl'

describe Services::Shorl do
  its(:hostname) { should == 'shorl.com'   }
  its(:action)   { should == '/create.php' }

  let(:url)      { "http://www.google.com/#{rand(1024)}" }
  let(:shorturl) { /^http:\/\/shorl\.com\/[a-z]{13}$/    }

  include_context "Services"
end
