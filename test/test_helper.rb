require 'coveralls'
Coveralls.wear!

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'ostruct'
require 'action_controller'
require 'active_model_exporters'
require 'minitest/autorun'
require 'minitest/unit'
require 'minitest/pride'
require 'fixtures/locale'
require 'fixtures/models'
require 'fixtures/exporters'
require 'fixtures/active_record/models'
require 'fixtures/active_record/exporters'

ActiveSupport::TestCase.test_order = :random

module TestHelper
  Routes = ActionDispatch::Routing::RouteSet.new
  ActionController::Base.send(:include, Routes.url_helpers)

  actions = %w(
    single_resource
    filter_attributes
    implicit_exporter
    explicit_exporter
    calling_exportation_scope
    implicit_exportation_scope
    explicit_exportation_scope
  ).freeze

  Routes.draw do
    actions.each do |action|
      get action, action: action, controller: "action_controller/exportation/csv/#{action}_test/tests"
      get action, action: action, controller: "action_controller/exportation/xls/#{action}_test/tests"
    end
  end
end

class ActionController::TestCase
  def setup
    @routes = TestHelper::Routes
  end
end
