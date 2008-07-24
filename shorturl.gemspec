require "rubygems"

SPEC = Gem::Specification.new do |s|
  s.name = "shorturl"
  s.version = "0.8.4"
  s.author = "Vincent Foley"
  s.email = "vfoleybourgon@yahoo.ca"
  s.homepage = "http://shorturl.rubyforge.org"
  s.platform = Gem::Platform::RUBY
  s.summary = "Shortens URLs using services such as RubyURL, urlTea, and TinyURL"
  candidates = Dir["{bin,lib,doc,test,examples}/**/*"]
  s.files = candidates
  s.require_path = "lib"
  s.autorequire = "shorturl"
  s.test_file = "test/ts_all.rb"
  s.has_rdoc = true
  s.extra_rdoc_files = ["README", "TODO", "MIT-LICENSE", "ChangeLog"]
  s.rdoc_options = [
    "--title", "ShortURL Documentation",
    "--main", "README",
    "-S",
    "-N",
    "--all"]
  s.default_executable = "shorturl"
  s.executables = ["shorturl"]
end
