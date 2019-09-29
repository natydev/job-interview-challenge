
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
