module ActiveModel
  class ArrayExporter
    attr_reader :collection, :exporter, :scope

    def initialize(collection, options = {})
      @collection = Array(collection)
      @scope      = options.delete(:scope)
      @exporter   = options.delete(:exporter)
    end

    def to_csv
      generate_file
    end

    def to_xls
      generate_file(col_sep: "\t")
    end

    private

    def generate_file(options = {})
      CSV.generate(options) do |file|
        file << headers
        collection.each do |object|
          file << exporter_for(object).values
        end
      end
    end

    def exporter_for(object)
      exporter_class = exporter || Exporter.exporter_for(object)
      exporter_class.new(object, scope: scope)
    end

    def headers
      object = collection.first
      attributes = exporter_for(object).attributes

      if object.class.respond_to?(:human_attribute_name)
        attributes.map { |attr| object.class.human_attribute_name(attr) }
      else
        attributes.map(&:to_s)
      end
    end
  end
end
