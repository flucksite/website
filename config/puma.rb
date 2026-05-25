# frozen_string_literal: true

# Environment and port.
port ENV.fetch("HANAMI_PORT", 2300)
environment ENV.fetch("HANAMI_ENV", "development")

# Threads within each Puma worker.
max_threads_count = ENV.fetch("HANAMI_MAX_THREADS", 5)
min_threads_count = ENV.fetch("HANAMI_MIN_THREADS") { max_threads_count }

threads min_threads_count, max_threads_count

# Worker (Puma process) count, typically one per available core.
puma_concurrency = Integer(ENV.fetch("HANAMI_WEB_CONCURRENCY", 0))
puma_cluster_mode = puma_concurrency > 1

workers puma_concurrency

if puma_cluster_mode
  # Preload the application before starting the workers (cluster mode only).
  preload_app!

  # Close preloaded remote connections before master forks workers.
  before_fork do
    Hanami.shutdown
  end
end
