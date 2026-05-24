# frozen_string_literal: true

require "dry/logger"

Dry::Logger.register_template(
  :details,
  "[<cyan>%<progname>s</cyan>]" \
  "[%<severity>s]" \
  "[<magenta>%<time>s</magenta>]" \
  "%<message>s %<payload>s"
)
Dry::Logger.register_template(
  :rack,
  "[<cyan>%<progname>s</cyan>] " \
  "[%<severity>s] " \
  "[<magenta>%<time>s</magenta>] " \
  "<green>%<verb>s</green> %<status>s " \
  "<yellow>%<elapsed>s</yellow> " \
  "%<ip>s <blue>%<path>s</blue> " \
  "%<length>s %<payload>s\n" \
  "  %<params>s\n"
)
