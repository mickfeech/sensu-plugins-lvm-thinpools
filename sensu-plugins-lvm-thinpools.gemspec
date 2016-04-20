lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'date'

if RUBY_VERSION < '2.0.0'
  require 'sensu-plugins-lvm-thinpools'
else
  require_relative 'lib/sensu-plugins-lvm-thinpools'
end

Gem::Specification.new do |s|
  s.name          = 'sensu-plugins-lvm-thinpools'
  s.version       = SensuPluginsLvmThinpools::Version::VER_STRING
  s.platform      = Gem::Platform::RUBY
  s.authors       = ['mickfeech and contributors']
  s.email         = ['cmcfee@kent.edu']
  s.homepage      = 'https://github.com/mickfeech/sensu-plugins-lvm-thinpools'
  s.summary       = 'This provides functionality to check lvm thinpools, like those that can be utilized for docker.'
  s.description   = 'Plugins to provide functionality to check lvm thinpools for Sensu, a monitoring framework'
  s.license       = 'MIT'
  s.has_rdoc      = false
  s.require_paths = ['lib']
  s.files         = Dir['lib/**/*.rb']
  #s.test_files    = Dir['test/*.rb']
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})

  s.add_runtime_dependency 'sensu-plugin', '~> 1.2'
  #s.add_dependency('json')
  #s.add_dependency('mixlib-cli', '>= 1.5.0')

  s.add_development_dependency('rake')
  s.add_development_dependency('minitest')
end