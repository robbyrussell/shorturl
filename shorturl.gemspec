require "rubygems"

require File.expand_path('../lib/shorturl/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "shorturl"
  gem.version       = ShortURL::VERSION
  gem.summary       = %q{Shortens URLs using services such as RubyURL, urlTea, bit.ly, moourl.com, and TinyURL}
  gem.license       = "MIT"
  gem.authors       = ["Robby Russell"]
  gem.email         = "robby@planetargon.com"
  gem.homepage      = "http://github.com/robbyrussell/shorturl/"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.extra_rdoc_files = %w[README.rdoc TODO.rdoc LICENSE.txt ChangeLog.txt]
  gem.rdoc_options = %w[
    --title ShortURL\ Documentation
    --main README.rdoc
    -S -N --all
  ]

  gem.add_development_dependency 'rdoc', '~> 3.0'
end
