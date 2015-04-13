# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'English'
require 'omnivault/version'

Gem::Specification.new do |spec|
  spec.name          = 'omnivault'
  spec.version       = Omnivault::VERSION
  spec.authors       = ['Frank Macreery']
  spec.email         = ['frank@macreery.com']
  spec.description   = 'Abstract password vault for multiple providers'
  spec.summary       = 'Abstract password vault for multiple providers'
  spec.homepage      = 'https://github.com/aptible/omnivault'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($RS)
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ['lib']

  spec.add_dependency 'aws-keychain-util'
  spec.add_dependency 'aws-pws'

  spec.add_development_dependency 'bundler', '~> 1.8'
  spec.add_development_dependency 'aptible-tasks'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 2.0'
end
