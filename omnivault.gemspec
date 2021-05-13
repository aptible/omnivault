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
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ['lib']
  spec.extensions = 'ext/mkrf_conf.rb'

  spec.add_dependency 'pws'
  spec.add_dependency 'thor'

  spec.add_development_dependency 'aptible-tasks'
  spec.add_development_dependency 'aws-sdk', '~> 2'
  spec.add_development_dependency 'aws-sdk-v1'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 10.4.2'
  spec.add_development_dependency 'rspec', '~> 2.0'
end
