module ActionController
  module Exportation
    extend ActiveSupport::Concern

    included do
      class_attribute :_exportation_scope
      self._exportation_scope = :current_user
    end

    module ClassMethods
      def exportation_scope(scope)
        self._exportation_scope = scope
      end
    end

    def _render_option_csv(resource, options)
      exporter = build_exporter(resource, options)
      exporter ? super(exporter, options) : super
    end

    private

    def build_exporter(resource, options)
      exporter = ActiveModel::Exporter.exporter_for(resource)
      exporter.new(resource, options) if exporter
    end
  end
end
