ActiveModel::Exporter::TYPES.each do |type|
  ActionController::Renderers.add type do |resource, options|
    method = "to_#{type}".to_sym

    if resource.respond_to?(method)
      encode = options[:encode] || 'iso-8859-1'
      mtype  = "Mime::#{type.upcase}".safe_constantize
      file   = resource.send(method).encode(encode)

      default_options = {type: mtype, disposition: 'attachment'}
      send_data(file, default_options.merge(options))
    else
      resource
    end
  end
end
