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
      method    = "to_#{type}".to_sym

      if resource.respond_to?(method)
        filename  = options[:filename]
        encoding  = options[:encoding] || 'iso-8859-1'
        mime_type = "Mime::#{type.upcase}".safe_constantize || Mime::TEXT

        file = resource.send(method).encode(encoding)
        options = {}
        options.merge!(type: mime_type)
        options.merge!(disposition: "attachment; filename=#{filename}.#{type}") if filename

        send_data file, options
      else
        resource
      end
    end
  end

  ActiveSupport.on_load(:action_controller) do
    include ::ActionController::Exportation
  end
end
