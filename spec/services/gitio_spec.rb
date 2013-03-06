require 'spec_helper'
require 'services/examples'
require 'shorturl/services/gitio'

describe Services::Gitio do
  its(:hostname) { should == 'git.io' }
  its(:code)     { should == 201      }

  let(:url)      { "https://github.com/robbyrussell/shorturl" }
  let(:shorturl) { "http://git.io/_KBNhA" }

  include_context "Services"
end
