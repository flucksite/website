# frozen_string_literal: true

module FluckWebsite
  # Inlines SVG files from search_paths with optional styling strip; cached per path/strip pair.
  module InlineSvg
    DEFAULT_SVGS_DIR = File.expand_path("../../app/assets/svgs", __dir__).freeze
    STRIP_REGEX = /(class|fill|stroke|stroke-width|style)="[^"]+" ?/

    class MissingError < StandardError; end

    class << self
      attr_writer :search_paths

      def cache
        @cache ||= {}
      end

      def search_paths
        @search_paths ||= [DEFAULT_SVGS_DIR]
      end

      def render(path, strip_styling: true, **attrs)
        key = [path, strip_styling]
        content = cache[key] ||= load(path, strip_styling: strip_styling)
        apply_attrs(content, path, strip_styling, attrs)
      end

      def load(path, strip_styling:)
        content = strip_whitespace(File.read(full_svg_path(path)))
        strip_styling ? content.gsub(STRIP_REGEX, "") : content
      end

      def apply_attrs(content, path, strip_styling, attrs)
        identifier = path.sub(/\.svg\z/, "")
        marker = "data-inline-svg#{strip_styling ? '' : '-styled'}"
        pairs = [%(#{marker}="#{identifier}")]
        attrs.each do |name, value|
          pairs << %(#{name.to_s.tr('_', '-')}="#{value}")
        end
        content.sub("<svg", "<svg #{pairs.join(' ')}")
      end

      private

      def full_svg_path(path)
        filename = path.end_with?(".svg") ? path : "#{path}.svg"
        full_path = search_paths
          .map { File.join(_1, filename) }
          .find { File.exist?(_1) }
        full_path || raise(
          MissingError,
          "SVG #{filename} not found in #{search_paths.inspect}"
        )
      end

      def strip_whitespace(content)
        content
          .gsub(/<\?xml[^>]+>/, "")
          .gsub(/<!--[^>]+>/, "")
          .gsub(/\n\s*/, " ")
          .strip
      end
    end
  end
end
