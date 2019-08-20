module ActiveModel
  class Exporter
    class << self
      attr_accessor :_attributes

      def inherited(base)
        base._attributes = (_attributes || []).dup
      end

      def attributes(*attrs)
        @_attributes.concat(attrs)
      end

      def exporter_for(resource)
        "#{resource.class.name}Exporter".safe_constantize
      end
    end


    attr_reader :object, :scope

    def initialize(object, options = {})
      @object = object
      @scope  = options[:scope]
    end

    def values
      attrs = filter(attributes)
      attributes.map do |attr|
        if attrs.include?(attr)
          next send(attr) if respond_to?(attr)
          object.send(attr)
        end
      end
    end

    def filter(attrs)
      attrs
    end

    def attributes
      self.class._attributes.dup
    end
  end
end
