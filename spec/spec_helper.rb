gem 'rspec', '~> 2.4'
require 'rspec'
require 'shorturl'

include ShortURL

require 'uri'

RSpec::Matchers.define :be_a_url do
  match do |actual|
    URI(actual).scheme.downcase == "http"
  end
end
