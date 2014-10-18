version = File.exist?("VERSION") ? File.read("VERSION") : ""

Gem::Specification.new do |s|
  s.name = 'chef2wiki'
  s.version = version
  s.platform = Gem::Platform::RUBY
  s.extra_rdoc_files = ["README.md", "LICENSE" ]
  s.summary = "Generates wiki documentation from Chef node attributes using ERB templates."
  s.description = s.summary
  s.license = "MIT"
  s.author = "Ivan Larionov"
  s.email = "xeron.oskom@gmail.com"
  s.homepage = "http://github.com/xeron/chef2wiki"

  s.required_ruby_version = ">= 1.9.3"

  s.add_dependency "chef", '~> 11.16'
  s.add_dependency "mediawiki-gateway", '~> 0.6', '>= 0.6.2'

  s.bindir = "bin"
  s.executables = %w( chef2wiki )

  s.require_path = 'lib'
  s.files = %w(Rakefile LICENSE README.md) + Dir.glob("lib/**/*", File::FNM_DOTMATCH).reject { |f| File.directory?(f) }
end
