# frozen_string_literal: true

require "csv"
require "active_model"
require "active_model/exporter"
require "active_model/exporter/types"
require "active_model/array_exporter"
require "active_model/exporter/version"

if defined?(ActionController)
  require "action_controller/exportation"
  require "action_controller/exportation/mime_types"
  require "action_controller/exportation/renderers"

  ActiveSupport.on_load(:action_controller) do
    include ::ActionController::Exportation
  end
end
