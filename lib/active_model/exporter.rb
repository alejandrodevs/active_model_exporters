module ActiveModel
  class Exporter
    class << self
      attr_accessor :_attributes

      def inherited(base)
        base._attributes = (_attributes || []).dup
      end

      def attributes(*attrs)
        @_attributes.concat(attrs)

        attrs.each do |attr|
          define_method(attr) do
            object.send(attr)
          end unless method_defined?(attr)
        end
      end

      def exporter_for(resource)
        if resource.respond_to?(:to_ary)
          ArrayExporter
        else
          "#{resource.class.name}Exporter".safe_constantize
        end
      end
    end


    attr_accessor :object, :scope

    def initialize(object, options = {})
      @object = object
      @scope  = options[:scope]
    end

    def values
      attrs = filter(attributes)
      attributes.map { |attr| send(attr) if attrs.include?(attr) }
    end

    private

    def filter(attrs)
      attrs
    end

    def attributes
      self.class._attributes.dup
    end
  end
end
