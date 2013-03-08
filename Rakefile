require "rake"
require "rake/testtask"
require "rdoc/task"

task :default => [ :test, :doc ]

begin
  gem 'rspec', '~> 2.4'
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new
rescue LoadError => e
  task :spec do
    abort "Please run `gem install rspec` to install RSpec."
  end
end

task :test    => :spec
task :default => :spec

desc "Write the documentation"
RDoc::Task.new("doc") { |rdoc|
  rdoc.rdoc_dir = "doc"
  rdoc.title = "ShortURL Documentation"
#  rdoc.options << "--line-numbers --inline-source"
  rdoc.rdoc_files.include("README.rdoc")
  rdoc.rdoc_files.include("TODO.rdoc")
  rdoc.rdoc_files.include("LICENSE.txt")
  rdoc.rdoc_files.include("ChangeLog.txt")
  rdoc.rdoc_files.include("lib/*.rb")
  rdoc.rdoc_files.exclude("test/*")
}

desc "Upload documentation to RubyForge"
task :upload_doc do
  sh "scp -r doc/* robbyrussell@rubyforge.org:/var/www/gforge-projects/shorturl"
end


desc "Statistics for the code"
task :stats do
  begin
    require "code_statistics"
    CodeStatistics.new(["Code", "lib"],
                       ["Units", "test"]).to_s
  rescue LoadError
    puts "Couldn't load code_statistics (install rails)"
  end
end
