# frozen_string_literal: true

module ActionView
  # = Action View CSRF Helper
  module Helpers #:nodoc:
    module CsrfHelper
      # Returns meta tags "csrf-param" and "csrf-token" with the name of the cross-site
      # request forgery protection parameter and token, respectively.
      #
      #   <head>
      #     <%= csrf_meta_tags %>
      #   </head>
      #
      # These are used to generate the dynamic forms that implement non-remote links with
      # <tt>:method</tt>.
      #
      # You don't need to use these tags for regular forms as they generate their own hidden fields.
      #
      # For AJAX requests other than GETs, extract the "csrf-token" from the meta-tag and send as the
      # "X-CSRF-Token" HTTP header. If you are using rails-ujs this happens automatically.
      #
      def csrf_meta_tags
        if defined?(protect_against_forgery?) && protect_against_forgery?
          [
            tag("meta", name: "csrf-param", content: request_forgery_protection_token),
            tag("meta", name: "csrf-token", content: form_authenticity_token)
          ].join("\n").html_safe
        end
      rescue ActionDispatch::Request::Session::DisabledSessionError
        if Rails.application.config.action_dispatch.silence_disabled_session_errors
          # TODO: The deprecation message need work
          ActiveSupport::Deprecation.warn(<<-MSG.squish)
            Calling `csrf_meta_tags` when session are disabled is deprecated. Either configure session or disable CSRF protection
          MSG
          nil
        else
          raise
        end
      end

      # For backwards compatibility.
      alias csrf_meta_tag csrf_meta_tags
    end
  end
end
