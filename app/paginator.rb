# frozen_string_literal: true

module FluckWebsite
  class Paginator
    include Pagy::Method

    Pagination = Data.define(
      :current_page,
      :pages,
      :previous_page,
      :next_page,
      :series
    )

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

    # `#series` is protected in Pagy 43, so this reaches past visibility here.
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
