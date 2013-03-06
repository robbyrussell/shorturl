require 'spec_helper'
require 'shorturl'

describe ShortURL do
  describe "shorten" do
    let(:url) { 'http://groups.google.com/group/comp.lang.ruby/' }

    it "should shorten the url" do
      subject.shorten(url).should be_a_url
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
