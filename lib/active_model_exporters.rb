require 'csv'
require 'active_model'
require 'active_model/exporter'
require 'active_model/exporter/types'
require 'active_model/array_exporter'
require 'active_model/exporter/version'

if defined?(ActionController)
  require 'action_controller/exportation'

  Mime::Type.register('application/vnd.ms-excel', :xls)

  ActiveModel::Exporter::TYPES.each do |type|
    ActionController::Renderers.add type do |resource, options|
      filename  = options[:filename] || 'data'
      charset   = options[:charset]  || 'iso-8859-1'
      mime_type = "Mime::#{type.upcase}".safe_constantize || Mime::TEXT
      method    = "to_#{type}".to_sym

      if resource.respond_to?(method)
        send_data resource.send(method), type: "#{mime_type.to_s}; charset=#{charset}; header=present",
                                         disposition: "attachment; filename=#{filename}.#{type}"
      else
        resource
      end
    end
  end

  ActiveSupport.on_load(:action_controller) do
    include ::ActionController::Exportation
  end
end
