require 'csv'
require 'active_model'
require 'active_model/exporter'
require 'active_model/exporter/types'
require 'active_model/array_exporter'
require 'active_model/exporter/version'

if defined?(ActionController)
  require 'action_controller/exportation'

  Mime::Type.register('application/vnd.ms-excel', :xls)
  Mime::Type.register('application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', :xlsx)

  ActiveModel::Exporter::TYPES.each do |type|
    ActionController::Renderers.add type do |resource, options|
      method = "to_#{type}".to_sym
      self.content_type ||= "Mime::#{type.upcase}".safe_constantize
      resource.respond_to?(method) ? resource.send(method) : resource
    end
  end

  ActiveSupport.on_load(:action_controller) do
    include ::ActionController::Exportation
  end
end
