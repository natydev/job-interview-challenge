# frozen_string_literal: true

module Tractus
  # Provides general behaviour for models.
  module ModelShared
    def self.included(base)
      base.send :extend, ClassMethods
      base.send :extend, Dry::Initializer
      base.send :extend, Forwardable

      class_eval do
        # retrieve hash of public attributes with values
        # defined by initializer methods
        def attributes
          self.class.dry_initializer.public_attributes(self)
        end

        alias_method :output, :attributes
      end
    end

    # :nodoc:
    module ClassMethods
    end
  end
end
