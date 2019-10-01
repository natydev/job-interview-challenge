# frozen_string_literal: true

module Tractus
  # transform JSON string (from a JSON file) in an array of models
  # (see sub-classes)
  class Importer
    include OperationShared
    initialize_with :path

    def read_data
      JSON.parse(File.read(path))
    end

    # transform JSON string in an array of Period objects
    class Periods < self
      def call
        read_data['periods'].map do |period|
          Period.new(id: period['id'], since: period['since'],
                     until: period['until'])
        end
      end
    end

    # transform JSON string in an array of Developer objects
    class Developers < self
      def call
        read_data['developers'].map do |dev|
          Developer.new(id: dev['id'], name: dev['name'],
                        birth_on: dev['birthday'])
        end
      end
    end

    # transform JSON string in an array of Project objects
    class Projects < self
      def call
        read_data['projects'].map do |period|
          Project.new(
            id: period['id'], since: period['since'],
            until: period['until'], effort_days: period['effort_days']
          )
        end
      end
    end
  end
end
