require 'spec_helper'
require 'shorturl/service'

describe Service do
  describe "#initialize" do
    subject { described_class.new('tinyurl.com') }
    
    its(:hostname) { should == 'tinyurl.com' }

    its(:port)   { should == 80    }
    its(:code)   { should == 200   }
    its(:method) { should == :post }
    its(:action) { should == '/'   }
    its(:field)  { should == 'url' }

    context "when given a block" do
      subject do
        described_class.new("tinyurl.com") do |s|
          s.port = 8080
          s.code = 302
          s.method = :get
          s.action = "/create.php"
          s.field = "link"
        end
      end

      its(:port)   { should == 8080 }
      its(:code)   { should == 302  }
      its(:method) { should == :get }
      its(:action) { should == '/create.php' }
      its(:field)  { should == 'link' }
    end
  end

  describe "#call" do
    context "when the hostname does not resolv" do
      subject { described_class.new("oasdasobf") }

      it "should raise SocketError" do
        lambda { subject.call(nil) }.should raise_error(SocketError)
      end
    end

    context "when the request code does not match" do
      subject do
        described_class.new('tinyurl.com') do |s|
          s.code = 404
          s.action = "/create.php"
          s.block = lambda { |body|
            URI.extract(body).grep(/tinyurl/)[-1]
          }
        end
      end

      it "should return nil" do
        subject.call('http://www.google.com').should be_nil
      end
    end
  end
end
