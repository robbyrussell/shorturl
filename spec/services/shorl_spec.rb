require 'spec_helper'
require 'services/examples'
require 'shorturl/services/shorl'

describe Services::Shorl do
  its(:hostname) { should == 'shorl.com'   }
  its(:action)   { should == '/create.php' }

  let(:url)      { "http://www.google.com/" }
  let(:shorturl) { "http://shorl.com/balagrehysyjy" }

  include_context "Services"
end
