# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "chef2wiki"
  gem.homepage = "http://github.com/xeron/chef2wiki"
  gem.license = "MIT"
  gem.summary = "Generates wiki documentation from Chef node attributes"
  gem.description = %Q{TODO: longer description of your gem}
  gem.email = "xeron.oskom@gmail.com"
  gem.authors = ["Ivan Larionov"]
end
Jeweler::RubygemsDotOrgTasks.new

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?("VERSION") ? File.read("VERSION") : ""

  rdoc.rdoc_dir = "rdoc"
  rdoc.title = "chef2wiki #{version}"
  rdoc.rdoc_files.include("README*")
  rdoc.rdoc_files.include("lib/**/*.rb")
end
