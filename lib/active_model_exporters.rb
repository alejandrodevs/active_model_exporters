require 'csv'
require 'active_model'
require 'active_model/exporter'
require 'active_model/array_exporter'
require 'active_model/exporter/version'

begin
  require 'action_controller'
  require 'action_controller/exportation'

  ActiveSupport.on_load(:action_controller) do
    include ::ActionController::Exportation
  end
rescue LoadError
  # rails not installed, continuing
end
