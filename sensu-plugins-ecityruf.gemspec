lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'date'
require_relative 'lib/sensu/plugins/ecityruf'

Gem::Specification.new do |spec|
  spec.name        = 'sensu-plugins-ecityruf'
  spec.version     = Sensu::Plugins::Ecityruf::VERSION
  spec.authors     = ['Hauke Altmann']
  spec.email       = ['hauke.altmann@aboutsource.net']
  spec.executables = Dir.glob('bin/**/*.rb').map { |file| File.basename(file) }
  spec.files       = Dir.glob('{bin,lib}/**/*') + %w[LICENSE README.md]
  spec.platform    = Gem::Platform::RUBY
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.4.0'

  spec.summary       = 'Sensu handler for ecityruf service'
  spec.description   = 'Handler to alert e*Cityruf pagers'
  spec.homepage      = 'https://www.aboutsource.net'
  spec.license       = 'MIT'

  spec.add_runtime_dependency 'sensu-plugin', '~> 2.5'

  spec.add_development_dependency 'bundler',  '~> 1.16'
  spec.add_development_dependency 'rake',     '~> 10.0'
  spec.add_development_dependency 'rspec',    '~> 3.7'
  spec.add_development_dependency 'rubocop',  '~> 0.54'
  spec.add_development_dependency 'webmock',  '~> 3.3'
end
