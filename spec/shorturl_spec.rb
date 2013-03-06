require 'spec_helper'
require 'shorturl'

describe ShortURL do
  describe "shorten" do
    let(:url)      { "http://www.google.com/" }
    let(:shorturl) { "http://tinyurl.com/161" }

    it "should shorten the url using tinyurl.com" do
      subject.shorten(url).should == shorturl
    end

    context "when an alternate service is given" do
      let(:shorturl) { "http://ln-s.net/F" }

      it "should use the alternate service" do
        subject.shorten(url,:lns).should == shorturl
      end
    end

    context "when given an invalid service" do
      it "should raise an InvalidService exception" do
        lambda {
          subject.shorten(url,:foobar)
        }.should raise_error(InvalidService)
      end
    end
  end
end
