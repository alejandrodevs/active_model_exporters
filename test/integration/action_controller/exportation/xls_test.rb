# frozen_string_literal: true

require "test_helper"

module ActionController
  module Exportation
    module XLS
      class ImplicitExporterTest < ActionController::TestCase
        class TestsController < ActionController::Base
          def implicit_exporter
            render xls: [
              User.new(first_name: "Foo1", last_name: "Bar1"),
              User.new(first_name: "Foo2", last_name: "Bar2"),
              User.new(first_name: "Foo3", last_name: "Bar3")
            ]
          end
        end

        tests TestsController

        def test_render_using_implicit_exporter
          get :implicit_exporter
          assert_equal "application/vnd.ms-excel", @response.content_type
          assert_equal "First name\tLast name\tFull name\n" \
                       "Foo1\tBar1\tFoo1-Bar1\n" \
                       "Foo2\tBar2\tFoo2-Bar2\n" \
                       "Foo3\tBar3\tFoo3-Bar3\n", @response.body
        end
      end

      class ExplicitExporterTest < ActionController::TestCase
        class TestsController < ActionController::Base
          def explicit_exporter
            render xls: [
              User.new(first_name: "Foo1", last_name: "Bar1")
            ], exporter: FancyUserExporter
          end
        end

        tests TestsController

        def test_render_using_explicit_exporter
          get :explicit_exporter
          assert_equal "application/vnd.ms-excel", @response.content_type
          assert_equal "First name\tLast name\n" \
                       "Foo1\tBar1\n", @response.body
        end
      end

      class ImplicitExportationScopeTest < ActionController::TestCase
        class TestsController < ActionController::Base
          def implicit_exportation_scope
            render xls: [
              User.new(first_name: "Foo1", last_name: "Bar1")
            ]
          end

          private

          def current_user
            "current_user"
          end
        end

        tests TestsController

        def test_render_using_implicit_exportation_scope
          get :implicit_exportation_scope
          assert_equal "application/vnd.ms-excel", @response.content_type
          assert_equal "First name\tLast name\tFull name\n" \
                       "Foo1\tBar1\tFoo1-Bar1-current_user\n", @response.body
        end
      end

      class ExplicitExportationScopeTest < ActionController::TestCase
        class TestsController < ActionController::Base
          def explicit_exportation_scope
            render xls: [
              User.new(first_name: "Foo1", last_name: "Bar1")
            ], scope: current_admin
          end

          private

          def current_admin
            "current_admin"
          end
        end

        tests TestsController

        def test_render_using_explicit_exportation_scope
          get :explicit_exportation_scope
          assert_equal "application/vnd.ms-excel", @response.content_type
          assert_equal "First name\tLast name\tFull name\n" \
                       "Foo1\tBar1\tFoo1-Bar1-current_admin\n", @response.body
        end
      end

      class CallingExportationScopeTest < ActionController::TestCase
        class TestsController < ActionController::Base
          exportation_scope :current_admin

          def calling_exportation_scope
            render xls: [
              User.new(first_name: "Foo1", last_name: "Bar1")
            ]
          end

          private

          def current_admin
            "current_admin"
          end
        end

        tests TestsController

        def test_render_calling_exportation_scope
          get :calling_exportation_scope
          assert_equal "application/vnd.ms-excel", @response.content_type
          assert_equal "First name\tLast name\tFull name\n" \
                       "Foo1\tBar1\tFoo1-Bar1-current_admin\n", @response.body
        end
      end

      class FilterAttributesTest < ActionController::TestCase
        class TestsController < ActionController::Base
          def filter_attributes
            render xls: [
              User.new(first_name: "Foo1", last_name: "Bar1", email: "FooBar1@email.com"),
              User.new(first_name: "Foo2", last_name: "Bar2", email: "FooBar2@email.com")
            ], exporter: FilterUserExporter
          end
        end

        tests TestsController

        def test_render_using_filter_attributes
          get :filter_attributes
          assert_equal "application/vnd.ms-excel", @response.content_type
          assert_equal "First name\tLast name\tEmail\n" \
                       "Foo1\t\tFooBar1@email.com\n" \
                       "Foo2\tBar2\tFooBar2@email.com\n", @response.body
        end
      end

      class SingleResourceTest < ActionController::TestCase
        class TestsController < ActionController::Base
          def single_resource
            render xls: User.new(first_name: "Foo1", last_name: "Bar1")
          end
        end

        tests TestsController

        def test_render_single_resource
          get :single_resource
          assert_equal "application/vnd.ms-excel", @response.content_type
          assert_equal "First name\tLast name\tFull name\n" \
                       "Foo1\tBar1\tFoo1-Bar1\n", @response.body
        end
      end
    end
  end
end
