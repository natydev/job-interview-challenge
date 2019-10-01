# frozen_string_literal: true

module Tractus
  # Subclass of Availability object marshalling
  # used to collect availability data about individual developer
  # in a specific period
  class DevAvailability < Availability
    option :developer, reader: :protected
    option :availability, reader: :protected
    option :period, optional: true

    def_delegator :@availability, :period, :availability_period

    def developer_id
      developer.id
    end

    def output
      super.merge(
        developer_id: developer_id
      )
    end

    protected

    def period
      availability.period
    end
  end
end
