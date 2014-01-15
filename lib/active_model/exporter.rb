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
    end
  end
end
