require 'active_model_exporters'
require 'rails/all'

require 'coveralls'
Coveralls.wear!
Coveralls::Output.silent = true

require 'simplecov'
SimpleCov.start do
  minimum_coverage 90
end
