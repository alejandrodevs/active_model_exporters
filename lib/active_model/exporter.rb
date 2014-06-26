require 'csv'

module ActiveModel
  class Exporter
    attr_accessor :collection

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

    def initialize(collection)
      @collection = collection
    end

    def to_csv
      CSV.generate do |file|
        file << headers
      end
    end

    def headers
      ['Name', 'Email', 'Age']
    end
  end
end
