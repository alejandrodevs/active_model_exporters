module ActiveModel
  class ArrayExporter
    attr_reader :collection, :exporter, :scope

    def initialize(collection, options = {})
      @collection = collection
      @scope      = options[:scope]
      @exporter   = options[:exporter]
    end

    def to_csv(options = {})
      generate(options)
    end

    def to_xls(options = {})
      options[:col_sep] = "\t"
      generate(options)
    end

    alias :to_xlsx :to_xls

    def generate(options = {})
      CSV.generate(options) do |file|
        collection.each do |object|
          exporter = exporter_for(object)
          file << exporter.values
        end
      end
    end

    private

    def exporter_for(object)
      exporter_class = exporter || Exporter.exporter_for(object)
      exporter_class.new(object, scope: scope)
    end
  end
end
