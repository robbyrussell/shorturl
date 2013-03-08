require 'spec_helper'
require 'shorturl/service'

describe Service do
  subject { described_class.new('tinyurl.com') }

  let(:url) { 'http://www.google.com/' }

  describe "#initialize" do
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

  describe "#on_body" do
    let(:body) { "<b>http://tinyurl.com/161</b>" }

    it "should return the body as-is" do
      subject.on_body(body).should == body
    end
  end

  describe "#on_response" do
    let(:body)     { "<b>http://tinyurl.com/161</b>" }
    let(:response) { mock('Net::HTTPResponse')        }

    it "should call #read_body on the response" do
      response.should_receive(:read_body).and_return(body)
      subject.should_receive(:on_body).with(body)

      subject.on_response(response)
    end
  end

  describe "#call" do
    context "when the hostname does not resolv" do
      subject { described_class.new("oasdasobf") }

      it "should raise SocketError" do
        lambda { subject.call(url) }.should raise_error(SocketError)
      end
    end

    context "when given a non-String object" do
      let(:uri) { URI(url) }

      subject do
        described_class.new('tinyurl.com') do |s|
          s.code = 200
          s.action = "/create.php"
        end
      end

      it "should convert the URL to a String" do
        uri.should_receive(:to_s).and_return(url)

        subject.call(uri)
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
        subject.call(url).should be_nil
      end
    end
  end
end
