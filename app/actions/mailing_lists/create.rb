# frozen_string_literal: true

require "otori/hanami"

module FluckWebsite
  module Actions
    module MailingLists
      class Create < FluckWebsite::Action
        include Otori::Hanami::Action
        include Deps[subscribe: "mailing_lists.subscribe"]

        rate_limit method: :post, path: "/mailing_lists", limit: 10, period: 60
        honeypot "subscription[name]"

        params do
          required(:subscription).hash do
            required(:tag).filled(:string)
            required(:email).filled(:string)
            optional(:website).maybe(:string)
            optional(:name).maybe(:string)
          end
          optional(:honeypot_signals).maybe(:string)
        end

        def handle(request, response)
          sub = request.params[:subscription] || {}
          result = subscribe_to_mailinglist(sub, request)

          response.status = 422 if result.failure?
          response.render(view, **view_attrs(sub, result))
        end

        private

        def subscribe_to_mailinglist(sub, request)
          subscribe.call(
            tag: sub[:tag].to_s,
            email: sub[:email].to_s,
            website: sub[:website].to_s,
            signals_rating: Otori.signals_rating(request.params.to_h)
          )
        end

        def view_attrs(sub, result)
          {
            list_tag: sub[:tag].to_s,
            email_value: sub[:email].to_s,
            website_value: sub[:website].to_s,
            success: result.success?,
            email_errors: result.failure ? [t(".#{result.failure}")] : []
          }
        end
      end
    end
  end
end
