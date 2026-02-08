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
      if LuckyEnv.development?
        asset_hosts = "http://127.0.0.1:3000 http://fluck.localhost:3000"
        io << "connect-src 'self' #{asset_hosts} ws://127.0.0.1:3002 ws://fluck.localhost:3002 ws://fluck.localhost:3001 http://fluck.localhost:3001; "
      else
        asset_hosts = Lucky::Server.settings.asset_host
        io << "connect-src 'self' https://plausible.io; "
      end

      io << "default-src 'self'; "
      io << "frame-ancestors 'none'; "
      io << "base-uri 'self'; "
      io << "form-action 'self'; "
      io << "worker-src 'self' blob:; "
      io << "script-src 'self' 'unsafe-inline' 'unsafe-eval' #{asset_hosts} https://js.prosopo.io https://plausible.io; "
      io << "style-src 'self' 'unsafe-inline' #{asset_hosts}; "
      io << "font-src 'self' data: #{asset_hosts}; "
      io << "img-src 'self' data: #{asset_hosts}; "
    end
  end

  private def frame_guard_value : String
    "deny"
  end
end
