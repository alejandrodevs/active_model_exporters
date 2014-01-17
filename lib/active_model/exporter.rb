module ActiveModel
  class Exporter
    class << self
      attr_accessor :_attributes, :_headers

      alias_method :headers, :_headers

      def inherited(base)
        base._attributes = (_attributes || []).dup
      end

      def attributes(*attrs)
        @_attributes.concat(attrs)
      end
    end
  end
end
