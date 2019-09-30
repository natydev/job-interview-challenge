begin
  gem 'dry-initializer', '3.0.1'
  gem 'dry-types', '1.1.1'
  gem 'holidays', '7.1.0'
  gem 'memoist', '0.16.0'
  gem 'smart_init', '3.3.0'
rescue Gem::LoadError, LoadError
  puts "Could not find one or more required gems, " \
   "please run 'bundle install'"
end

require './lib/tractus'

# ============ LEVEL 1 ========================

# == Level 1 - list requirements:
# - install gems for development / testing.
# - make model Period, I'll use "dry-initializer" and  "dry-types" gems
#  to define attributes.
# - import raw data periods in an array of period objects.
# - for calculate holidays i found gem "holidays", so I'll use that.
# - Make a model Day to retrieve worday, weekend or holiday for  
#  each date of a Period; use "memoist" gem to cache some methods.
# - make model Availability
# - For each Period make an Availability an set in it the calculated data. 
# - export all calculated Availabilities into a json file

Tractus.run_first_level
