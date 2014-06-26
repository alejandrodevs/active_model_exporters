module ActiveModel
  class Exporter
    class << self
      attr_accessor :_attributes, :_headers, :_filename

      alias :headers :_headers=
      alias :filename :_filename=

      def inherited(base)
        base._attributes = (_attributes || []).dup
        base._headers = _headers || true
      end

      def attributes(*attrs)
        @_attributes.concat(attrs)
      end
    end


    attr_accessor :collection,
                  :attributes,
                  :headers,
                  :filename

    def initialize(collection, options = {})
      @collection = collection

      @attributes = self.class._attributes.dup
      @headers    = self.class._headers
      @filename   = self.class._filename
    end

    def to_csv
      CSV.generate do |file|
        file << attributes.map(&:to_s) if headers
        collection.each { |obj| file << values_for(obj) }
      end
    end

    def values_for(object)
      attributes.map do |attr|
        object.send(attr.to_sym)
      end
    end
  end
end
