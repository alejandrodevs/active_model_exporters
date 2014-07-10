module ActiveModel
  class ArrayExporter
    attr_reader :collection, :exporter, :scope

    def initialize(collection, options = {})
      @collection = collection
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
      exporter_for(collection.first).class._attributes
    end
  end
end
