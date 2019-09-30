# frozen_string_literal: true

module Tractus
  # Developer object marshalling
  class Developer
    include ModelShared

    option :id, Dry::Types['coercible.integer']
    option :name, Dry::Types['strict.string']
    option :birth_on, Dry::Types['params.date']

    # calculate birthday from birth_on
    # birthday on feb 29 will rounded to 28 in non-leap years
    def birthday(year = Date.today.year)
      birth_on.next_year(year - birth_on.year)
    end
  end
end
