require 'spec_helper'

shared_examples_for "Services" do
  describe "#call" do
    let(:shortened_url) { subject.call(url) }

    it "should shorten the given URL" do
      shortened_url.should == shorturl
    end

    describe "shortened url" do
      subject { Net::HTTP.get_response(URI(shorturl)) }

      it "should redirect to the original URL" do
        subject.code.should =~ /^30\d$/
        subject['location'].should == url
      end
    end
  end
end
