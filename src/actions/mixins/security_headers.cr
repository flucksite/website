module SecurityHeaders
  macro included
    # This module disables Google FLoC by setting the
    # [Permissions-Policy](https://github.com/WICG/floc) HTTP header to `interest-cohort=()`.
    #
    # This header is a part of Google's Federated Learning of Cohorts (FLoC) which is used
    # to track browsing history instead of using 3rd-party cookies.
    #
    # Remove this include if you want to use the FLoC tracking.
    include Lucky::SecureHeaders::DisableFLoC

    include Lucky::SecureHeaders::SetCSPGuard
    include Lucky::SecureHeaders::SetFrameGuard
    include Lucky::SecureHeaders::SetSniffGuard
    include Lucky::SecureHeaders::SetXSSGuard
  end

  private def csp_guard_value : String
    String.build do |io|
      io << "default-src 'self'; "
      io << "style-src 'self' 'unsafe-inline'; "
      io << "frame-ancestors 'none'; "
      io << "base-uri 'self'; "
      io << "form-action 'self'; "

      if LuckyEnv.development?
        io << "script-src 'self' 'unsafe-inline' http://127.0.0.1:3010 http://fluck.localhost:3010 https://js.prosopo.io https://plausible.io; "
        io << "font-src 'self' http://127.0.0.1:3010 http://fluck.localhost:3010; "
        io << "img-src 'self' data: https: http://127.0.0.1:3010 http://fluck.localhost:3010; "
        io << "connect-src 'self' ws://127.0.0.1:3010 http://127.0.0.1:3010 ws://fluck.localhost:3010 http://fluck.localhost:3010 ws://fluck.localhost:3001 http://fluck.localhost:3001; "
      else
        io << "script-src 'self' https://js.prosopo.io https://plausible.io; "
        io << "font-src 'self'; "
        io << "img-src 'self' data: https:; "
        io << "connect-src 'self' https://plausible.io; "
      end
    end
  end

  private def frame_guard_value : String
    "deny"
  end
end
