require 'rubygems'
require 'rubygems/package_task'

gemspec = eval(File.read("chef2wiki.gemspec"))
Gem::PackageTask.new(gemspec).define

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?("VERSION") ? File.read("VERSION") : ""

  rdoc.rdoc_dir = "rdoc"
  rdoc.title = "chef2wiki #{version}"
  rdoc.rdoc_files.include("README*")
  rdoc.rdoc_files.include("lib/**/*.rb")
end
