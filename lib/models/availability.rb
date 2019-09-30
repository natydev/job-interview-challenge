# frozen_string_literal: true

module Tractus
  # Availability object marshalling
  class Availability
    include ModelShared

    option :total_days, Dry::Types['coercible.integer'], default: proc { 0 }
    option :workdays, Dry::Types['coercible.integer'], default: proc { 0 }
    option :weekend_days, Dry::Types['coercible.integer'], default: proc { 0 }
    option :holidays, Dry::Types['coercible.integer'], default: proc { 0 }
    option :period, reader: :protected

    # display customised public attibutes
    def output
      attributes.merge(period_id: period.id)
    end

    # increment a numeric attribute by 1 or by specified 2nd argument
    def increment(atr, num = 1)
      instance_variable_set(
        "@#{atr}", instance_variable_get("@#{atr}") + num
      )
    end
  end
end
