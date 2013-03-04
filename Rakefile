require "rake"
require "rake/testtask"
require "rdoc/task"

task :default => [ :test, :doc ]

desc "Run the tests"
Rake::TestTask.new("test") { |t|
  t.pattern = "test/**/ts_*.rb"
  t.verbose = true
}

desc "Write the documentation"
RDoc::Task.new("doc") { |rdoc|
  rdoc.rdoc_dir = "doc"
  rdoc.title = "ShortURL Documentation"
#  rdoc.options << "--line-numbers --inline-source"
  rdoc.rdoc_files.include("README")
  rdoc.rdoc_files.include("TODO")
  rdoc.rdoc_files.include("MIT-LICENSE")
  rdoc.rdoc_files.include("ChangeLog")
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
