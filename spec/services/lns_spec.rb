require 'spec_helper'
require 'services/examples'
require 'shorturl/services/lns'

describe Services::Lns do
  its(:hostname) { should == 'ln-s.net'      }
  its(:method)   { should == :get            }
  its(:action)   { should == '/home/api.jsp' }

  let(:url)      { "http://www.google.com/" }
  let(:shorturl) { "http://ln-s.net/F" }

  include_context "Services"
end
