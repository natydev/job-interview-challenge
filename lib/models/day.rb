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

    def weekend?
      [0, 6].include?(value.wday)
    end
    memoize :weekend?

    def holiday?
      canonical_workday? && canonical_holiday?
    end

    def workday?
      canonical_workday? && !canonical_holiday?
    end

    private

    def canonical_workday?
      !weekend?
    end

    def canonical_holiday?
      Holidays.on(value, :it).any?
    end
    memoize :canonical_holiday?
  end
end
