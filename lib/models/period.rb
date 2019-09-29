# frozen_string_literal: true

module Tractus
  # Period object marshalling
  class Period
    include ModelShared

    option :id, Dry::Types['coercible.integer']
    option :since, Dry::Types['params.date']
    option :until, Dry::Types['params.date']

    def dates
      (since..self.until)
    end
  end
end
