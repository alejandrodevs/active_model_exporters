require 'test_helper'

module ActionController
  module Exportation
    class CSVTest < ActionController::TestCase
      class TestsController < ActionController::Base
        def export_to_csv
          render csv: [
            User.new(first_name: 'Foo1', last_name: 'Bar1')
          ]
        end

        def export_multiple_to_csv
          render csv: [
            User.new(first_name: 'Foo1', last_name: 'Bar1'),
            User.new(first_name: 'Foo2', last_name: 'Bar2'),
            User.new(first_name: 'Foo3', last_name: 'Bar3')
          ]
        end

        def export_to_csv_with_other_exporter
          render csv: [
            User.new(first_name: 'Foo1', last_name: 'Bar1')
          ], exporter: FancyUserExporter
        end
      end

      tests TestsController

      def test_export_to_csv
        get :export_to_csv
        assert_equal 'text/csv', @response.content_type
        assert_equal "Foo1,Bar1,Foo1-Bar1\n", @response.body
      end

      def test_export_multiple_to_csv
        get :export_multiple_to_csv
        assert_equal 'text/csv', @response.content_type
        assert_equal "Foo1,Bar1,Foo1-Bar1\n"\
                     "Foo2,Bar2,Foo2-Bar2\n"\
                     "Foo3,Bar3,Foo3-Bar3\n", @response.body
      end

      def test_export_to_csv_with_other_exporter
        get :export_to_csv_with_other_exporter
        assert_equal 'text/csv', @response.content_type
        assert_equal "Foo1,Bar1\n", @response.body
      end
    end
  end
end
