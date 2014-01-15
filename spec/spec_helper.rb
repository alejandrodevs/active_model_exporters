require 'active_model_exporters'

require 'coveralls'
Coveralls.wear!
Coveralls::Output.silent = true

Dir[Dir.pwd + '/spec/support/**/*.rb'].each { |f| require f }

require 'simplecov'
SimpleCov.start do
  minimum_coverage 90
end
