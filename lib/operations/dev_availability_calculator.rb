# frozen_string_literal: true

module Tractus
  # Create an object DevAvailability from Availability and Developer arguments
  # and re-calculate specific availability attributes for developer (workdays,
  # holidays), based on Period range since..until
  class DevAvailabilityCalculator
    extend Memoist
    include OperationShared
    initialize_with :availability, :developer

    def dev_availability
      DevAvailability.new(availability.attributes
        .merge(developer: developer, availability: availability))
    end
    memoize :dev_availability

    def call
      add_birthday
      dev_availability
    end

    private

    def add_birthday
      birthdays_in_period.each do |birthday|
        birthday_workday(Day.set(birthday))
      end
    end

    def change_availability
      dev_availability.decrement(:workdays)
      dev_availability.increment(:holidays)
    end

    def birthday_workday(day)
      change_availability if availability.dates.include?(day.value) &&
                             day.workday?
    end

    def birthdays_in_period
      years_in_period.map { |y| developer.birthday(y) }
    end
    memoize :birthdays_in_period

    def years_in_period
      availability.dates.map(&:year).uniq
    end
  end
end
