require 'test_helper'

module ActiveModel
  class Exporter
    class LocaleHeadersTest < Minitest::Test
      def setup
        @collection = [
          ARUser.new(first_name: 'ARFoo1', last_name: 'ARBar1'),
          ARUser.new(first_name: 'ARFoo2', last_name: 'ARBar2'),
          ARUser.new(first_name: 'ARFoo3', last_name: 'ARBar3')
        ]
      end

      def test_locale_headers
        exporter = ActiveModel::ArrayExporter.new(@collection)
        assert_equal "First,Last\n"\
                     "ARFoo1,ARBar1\n"\
                     "ARFoo2,ARBar2\n"\
                     "ARFoo3,ARBar3\n", exporter.to_csv
      end
    end
  end
end
