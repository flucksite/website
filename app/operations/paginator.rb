# frozen_string_literal: true

module FluckWebsite
  module Operations
    # Wraps Pagy so actions don't have to know about `include Pagy::Method`,
    # protected `series`, or pagy's mixed integer/string item types. Returns
    # `[paged_collection, Pagination]` where Pagination is a plain Data object
    # that templates can read directly.
    class Paginator
      include Pagy::Method

      Pagination = Data.define(:current_page, :pages, :previous_page, :next_page, :series)

      def call(items, request:)
        pagy_obj, paged = pagy(:offset, items, request: request)
        [paged, present(pagy_obj)]
      end

      private

      def present(pagy)
        Pagination.new(
          current_page: pagy.page,
          pages: pagy.pages,
          previous_page: pagy.previous,
          next_page: pagy.next,
          series: normalize_series(pagy)
        )
      end

      # `series` is protected in Pagy 43 and returns mixed types (Integer pages,
      # String for the current page, :gap for ellipsis). Map to a uniform hash
      # shape so templates can stay type-blind.
      def normalize_series(pagy)
        pagy.send(:series).map do |item|
          case item
          when :gap then {gap: true}
          when String then {number: item.to_i, current: true, gap: false}
          else {number: item, current: false, gap: false}
          end
        end
      end
    end
  end
end
