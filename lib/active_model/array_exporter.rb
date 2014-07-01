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

    alias :to_xlsx :to_xls

    def generate_file(options = {})
      CSV.generate(options) do |file|
        collection.each do |object|
          exporter = exporter_for(object)
          file << exporter.values
        end
      end.encode('ISO-8859-1')
    end

    private

    def exporter_for(object)
      exporter_class = exporter || Exporter.exporter_for(object)
      exporter_class.new(object, scope: scope)
    end
  end
end
