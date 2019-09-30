# frozen_string_literal: true

module Tractus
  # General behaviour to export entity objects into JSON file
  class Exporter
    include OperationShared
    initialize_with :items, :filename

    def call
      File.open(filename, 'w') { |file| file.write(json_data) }
    end

    private

    def json_data
      JSON.pretty_generate(wrap_attributes)
    end

    def wrap_attributes
      { Object.const_get("#{self.class.name}::WRAPPER") =>
       collect_attributes }
    end

    def collect_attributes
      items.map(&:output)
    end

    # Export Availability objects into JSON file
    class Availabilities < self
      WRAPPER = 'availabilities'
    end
  end
end
