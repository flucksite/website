# frozen_string_literal: true

require "rack/mock"
require "dry/inflector"
require "hanami/view/rendering"

module ScopeHelpers
  # Builds a Scope with a minimal context (routes, request, t, l).
  def build_scope(klass, locals: {}, path: "/")
    context = test_view_context(path: path)
    rendering = Struct.new(:context, :inflector).new(context, Dry::Inflector.new)
    klass.new(locals: locals, rendering: rendering)
  end

  def test_view_context(path: "/")
    request = Rack::Request.new(Rack::MockRequest.env_for(path))
    TestViewContext.new(request)
  end

  class TestViewContext
    def initialize(request)
      @request = request
    end

    attr_reader :request

    def routes
      Hanami.app["routes"]
    end

    def current_path
      @request.path
    end

    def t(key, **opts)
      I18n.t(key, **opts)
    end

    def l(value, **opts)
      I18n.l(value, **opts)
    end
  end
end

RSpec.configure do |config|
  config.include ScopeHelpers, type: :scope
end
