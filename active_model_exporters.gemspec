# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_model/exporters/version'

Gem::Specification.new do |spec|
  spec.name          = 'active_model_exporters'
  spec.version       = ActiveModel::Exporters::VERSION
  spec.authors       = ['Alejandro Gutiérrez']
  spec.email         = ['alejandrodevs@gmail.com']
  spec.description   = 'A simple way to export data in Rails.'
  spec.summary       = 'A simple way to export data in Rails.'
  spec.homepage      = 'https://github.com/alejandrogutierrez/active_model_exporters'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = ">= 1.9.3"

  spec.add_dependency 'activemodel', '>= 3.2'

  spec.add_development_dependency 'rails', '>= 3.2'
  spec.add_development_dependency 'rspec-rails', '~> 2.14.0'
  spec.add_development_dependency 'simplecov', '~> 0.7.1'
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
