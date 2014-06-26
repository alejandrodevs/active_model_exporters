require 'csv'
require 'active_model'
require 'active_model/exporter'
require 'active_model/array_exporter'
require 'active_model/exporter/version'

if defined?(ActionController)
  require 'action_controller/exportation'

  ActionController::Renderers.add :csv do |csv, options|
    self.content_type ||= Mime::CSV
    csv.respond_to?(:to_csv) ? csv.to_csv : csv
  end

  ActiveSupport.on_load(:action_controller) do
    include ::ActionController::Exportation
  end
end
