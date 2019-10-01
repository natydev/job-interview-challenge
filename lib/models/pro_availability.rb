# frozen_string_literal: true

module Tractus
  # Subclass of Availability object marshalling
  # used to collect availability data about a project
  class ProAvailability < Availability
    option :availability, reader: :protected
    option :team_workdays, Dry::Types['coercible.integer'],
           default: proc { 0 }, reader: :protected
    option :period, optional: true

    def output
      super.merge(
        feasibility: feasibility?
      )
    end

    def feasibility?
      team_workdays >= period.effort_days
    end

    protected

    def period
      availability.period
    end
  end
end
