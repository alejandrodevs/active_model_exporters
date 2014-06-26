module ActiveModel
  class ArrayExporter
    attr_reader :collection

    def initialize(collection, options = {})
      @collection = collection
    end

    def to_csv
      CSV.generate do |file|
        collection.each do |object|
          exporter = exporter_for(object)
          file << exporter.values
        end
      end
    end

    private

    def exporter_for(object)
      exporter_class = Exporter.exporter_for(object)
      exporter_class.new(object)
    end
  end
end
