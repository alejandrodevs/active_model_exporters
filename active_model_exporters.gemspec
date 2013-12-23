# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_model_exporters/version'

Gem::Specification.new do |spec|
  spec.name          = 'active_model_exporters'
  spec.version       = ActiveModelExporters::VERSION
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

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
