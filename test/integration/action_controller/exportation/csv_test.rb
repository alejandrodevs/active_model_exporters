require 'test_helper'

module ActionController
  module Exportation
    class ImplicitExporterTest < ActionController::TestCase
      class TestsController < ActionController::Base
        def render_using_implicit_exporter
          render csv: [
            User.new(first_name: 'Foo1', last_name: 'Bar1'),
            User.new(first_name: 'Foo2', last_name: 'Bar2'),
            User.new(first_name: 'Foo3', last_name: 'Bar3')
          ]
        end
      end

      tests TestsController

      def test_render_using_implicit_exporter
        get :render_using_implicit_exporter
        assert_equal 'text/csv', @response.content_type
        assert_equal "Foo1,Bar1,Foo1-Bar1\n"\
                     "Foo2,Bar2,Foo2-Bar2\n"\
                     "Foo3,Bar3,Foo3-Bar3\n", @response.body
      end
    end

    class ExplicitExporterTest < ActionController::TestCase
      class TestsController < ActionController::Base
        def render_using_explicit_exporter
          render csv: [
            User.new(first_name: 'Foo1', last_name: 'Bar1')
          ], exporter: FancyUserExporter
        end
      end

      tests TestsController

      def test_render_using_explicit_exporter
        get :render_using_explicit_exporter
        assert_equal 'text/csv', @response.content_type
        assert_equal "Foo1,Bar1\n", @response.body
      end
    end

    class ImplicitExportationScopeTest < ActionController::TestCase
      class TestsController < ActionController::Base
        def render_using_implicit_exportation_scope
          render csv: [
            User.new(first_name: 'Foo1', last_name: 'Bar1')
          ]
        end

        private

        def current_user
          'current_user'
        end
      end

      tests TestsController

      def test_render_using_implicit_exportation_scope
        get :render_using_implicit_exportation_scope
        assert_equal 'text/csv', @response.content_type
        assert_equal "Foo1,Bar1,Foo1-Bar1-current_user\n", @response.body
      end
    end

    class ExplicitExportationScopeTest < ActionController::TestCase
      class TestsController < ActionController::Base
        def render_using_explicit_exportation_scope
          render csv: [
            User.new(first_name: 'Foo1', last_name: 'Bar1')
          ], scope: current_admin
        end

        private

        def current_admin
          'current_admin'
        end
      end

      tests TestsController

      def test_render_using_explicit_exportation_scope
        get :render_using_explicit_exportation_scope
        assert_equal 'text/csv', @response.content_type
        assert_equal "Foo1,Bar1,Foo1-Bar1-current_admin\n", @response.body
      end
    end

    class CallingExportationScopeTest < ActionController::TestCase
      class TestsController < ActionController::Base
        exportation_scope :current_admin

        def render_calling_exportation_scope
          render csv: [
            User.new(first_name: 'Foo1', last_name: 'Bar1')
          ]
        end

        private

        def current_admin
          'current_admin'
        end
      end

      tests TestsController

      def test_render_calling_exportation_scope
        get :render_calling_exportation_scope
        assert_equal 'text/csv', @response.content_type
        assert_equal "Foo1,Bar1,Foo1-Bar1-current_admin\n", @response.body
      end
    end
  end
end
