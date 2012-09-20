# encoding: utf-8
module Holidays
  # This file is generated by the Ruby Holidays gem.
  #
  # Definitions loaded: data/us.yaml, data/north_america_informal.yaml
  #
  # To use the definitions in this file, load it right after you load the 
  # Holiday gem:
  #
  #   require 'holidays'
  #   require 'holidays/us'
  #
  # All the definitions are available at https://github.com/alexdunae/holidays
  module US # :nodoc:
    def self.defined_regions
      [:us, :us_dc, :ca]
    end

    def self.holidays_by_month
      {
              0 => [{:function => lambda { |year| Holidays.easter(year)-2 }, :function_id => "easter(year)-2", :type => :informal, :name => "Good Friday", :regions => [:us]},
            {:function => lambda { |year| Holidays.easter(year) }, :function_id => "easter(year)", :name => "Easter", :regions => [:us]}],
      1 => [{:mday => 1, :observed => lambda { |date| Holidays.to_weekday_if_weekend(date) }, :observed_id => "to_weekday_if_weekend", :name => "New Year's Day", :regions => [:us]},
            {:wday => 1, :week => 3, :name => "Martin Luther King, Jr. Day", :regions => [:us]},
            {:function => lambda { |year| Holidays.us_inauguration_day(year) }, :function_id => "us_inauguration_day(year)", :name => "Inauguration Day", :regions => [:us_dc]}],
      2 => [{:wday => 1, :week => 3, :name => "Presidents' Day", :regions => [:us]},
            {:mday => 2, :type => :informal, :name => "Groundhog Day", :regions => [:us, :ca]},
            {:mday => 14, :type => :informal, :name => "Valentine's Day", :regions => [:us, :ca]}],
      5 => [{:wday => 1, :week => -1, :name => "Memorial Day", :regions => [:us]},
            {:wday => 0, :week => 3, :type => :informal, :name => "Father's Day", :regions => [:us, :ca]}],
      7 => [{:mday => 4, :observed => lambda { |date| Holidays.to_weekday_if_weekend(date) }, :observed_id => "to_weekday_if_weekend", :name => "Independence Day", :regions => [:us]}],
      9 => [{:wday => 1, :week => 1, :name => "Labor Day", :regions => [:us]}],
      10 => [{:wday => 1, :week => 2, :name => "Columbus Day", :regions => [:us]},
            {:mday => 31, :type => :informal, :name => "Halloween", :regions => [:us, :ca]}],
      11 => [{:mday => 11, :observed => lambda { |date| Holidays.to_weekday_if_weekend(date) }, :observed_id => "to_weekday_if_weekend", :name => "Veterans Day", :regions => [:us]},
            {:wday => 5, :week => 4, :name => "Day After Thanksgiving", :regions => [:us]},
            {:wday => 4, :week => 4, :name => "Thanksgiving", :regions => [:us]}],
      12 => [{:mday => 24, :observed => lambda { |date| Holidays.to_weekday_if_weekend(date) }, :observed_id => "to_weekday_if_weekend", :name => "Christmas Eve", :regions => [:us]},
            {:mday => 25, :observed => lambda { |date| Holidays.to_weekday_if_weekend(date) }, :observed_id => "to_weekday_if_weekend", :name => "Christmas Day", :regions => [:us]},
            {:mday => 31, :observed => lambda { |date| Holidays.to_weekday_if_weekend(date) }, :observed_id => "to_weekday_if_weekend", :name => "New Years Eve", :regions => [:us]}],
      3 => [{:mday => 17, :type => :informal, :name => "St. Patrick's Day", :regions => [:us, :ca]}],
      4 => [{:mday => 1, :type => :informal, :name => "April Fool's Day", :regions => [:us, :ca]},
            {:mday => 22, :type => :informal, :name => "Earth Day", :regions => [:us, :ca]}]
      }
    end
  end

# January 20, every fourth year, following Presidential election
def self.us_inauguration_day(year)
  year % 4 == 1 ? 20 : nil
end



end

Holidays.merge_defs(Holidays::US.defined_regions, Holidays::US.holidays_by_month)
