require 'spec_helper'

shared_examples_for "Services" do
  describe "#call" do
    let(:shortened_url) { subject.call(url) }

    it "should shorten the given URL" do
      case shorturl
      when Regexp then shortened_url.should =~ shorturl
      else             shortened_url.should == shorturl
      end
    end

    describe "shortened url" do
      let(:response) { Net::HTTP.get_response(URI(shortened_url)) }

      it "should redirect to the original URL" do
        response.code.should =~ /^30\d$/
        response['location'].should == url
      end
    end
  end
end
