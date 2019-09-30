# frozen_string_literal: true

module Tractus
  # Day object marshalling
  class Day
    include ModelShared
    extend Memoist

    option :value, Dry::Types['strict.date']

    def self.set(value)
      new(value: value)
    end

    # returns true when is Sat or Sun
    def weekend?
      [0, 6].include?(value.wday)
    end
    memoize :weekend?

    # returns true when a holiday happens during a weekday
    def holiday?
      canonical_workday? && canonical_holiday?
    end

    # returns true in a weekday without holiday
    def workday?
      canonical_workday? && !canonical_holiday?
    end

    private

    def canonical_workday?
      !weekend?
    end

    # Instead of use data under key 'local_holidays' (of data.json)
    # I decided to contribute some days ago in GEM 'holidays' definitions
    # https://github.com/holidays/definitions/pull/144
    # So for now I hardcoded region 'it_pd', in future provide a dynamic
    # solution such as put key 'region' inside data.json > local_holidays items
    def canonical_holiday?
      Holidays.on(value, :it_pd).any?
    end
    memoize :canonical_holiday?
  end
end
