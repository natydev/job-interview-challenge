# frozen_string_literal: true

module Tractus
  # Provides general behaviour for operations.
  module OperationShared
    def self.included(base)
      base.send :extend, SmartInit
      base.send :is_callable
    end

    # :nodoc:
    module ClassMethods
    end
  end
end
