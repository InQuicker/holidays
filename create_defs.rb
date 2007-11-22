require 'yaml'

module_name = 'TestModule'

# Load the data files
files = ['data/ca.yaml']
regions = [] #wtf
rules_by_month = {}
custom_methods = {}

files.each do |file|
  def_file = YAML.load_file(file)
  def_file['months'].each do |month, definitions|
    rules_by_month[month] = []
    definitions.each do |definition|
      rule = {}
      definition.each do |key, val|
        rule[key] = val
      end
      regions = rule['regions'].collect { |r| r.to_sym }
      rule['regions'] = regions

      existed = false
#      rules_by_month[month].each do |ex|
#        if ex['name'] == rule['name'] and ex['wday'] == rule['wday'] and  ex['mday'] == rule['mday'] and ex['week'] == rule['week']
#          ex['regions'] << rule['regions'].flatten
#          existed = true
#        end
#      end
      unless existed
        rules_by_month[month] << rule
      end

    end # /defs.each

    def_file['methods'].each do |name, code|
      custom_methods[name] = code
    end # /methods.each
  end
end



# Build the definitions
month_strs = []
rules_by_month.each do |month, rules|
  month_str = "      #{month.to_s} => ["
  rule_strings = []
  rules.each do |rule|
    str = '{'
    if rule['mday']
      str << ":mday => #{rule['mday']}, "
    elsif rule['function']
      str << ":function => #{rule['function']}, "
    else
      str << ":wday => #{rule['wday']}, :week => #{rule['week']}, "
    end

    # shouldn't allow the same region twice
    str << ":name => \"#{rule['name']}\", :regions => [:" + rule['regions'].uniq.join(', :') + "]}"
    rule_strings << str
  end
  month_str << rule_strings.join(",\n            ") + "]"
  month_strs << month_str
end

month_strs.join(",\n")


# Build the methods
method_str = ''
custom_methods.each do |key, code|
  method_str << code + "\n\n"
end


# Build the output file
out =<<-EOC
# This file is generated by the Ruby Holiday gem.
#
# To use the definitions in the file, load them right after you load the 
# Holiday gem:
#
#   require 'holidays'
#   require 'path/to/#{module_name.downcase}'
#
# More definitions are available at http://code.dunae.ca/holidays.
#
# Definitions loaded: #{files.join(',')}
module Holidays
  module #{module_name}
    DEFINED_REGIONS = [:#{regions.join(', :')}]
    
    HOLIDAYS_BY_MONTH = {
#{month_strs.join(",\n")}
    }

#{method_str}
  end
end

Holidays.class_eval do
  existing_regions = []
  if const_defined?(:DEFINED_REGIONS) 
    existing_regions = const_get(:DEFINED_REGIONS)
    remove_const(:DEFINED_REGIONS)
  end
  const_set(:DEFINED_REGIONS, existing_regions | Holidays::#{module_name}::DEFINED_REGIONS)

  existing_defs = {}
  if const_defined?(:HOLIDAYS_BY_MONTH) 
    existing_defs = const_get(:HOLIDAYS_BY_MONTH)
    remove_const(:HOLIDAYS_BY_MONTH)
  end
  #const_set(:HOLIDAYS_BY_MONTH, existing_defs.merge(Holidays::#{module_name}::HOLIDAYS_BY_MONTH))
  const_set(:HOLIDAYS_BY_MONTH, Holidays::#{module_name}::HOLIDAYS_BY_MONTH)

  include Holidays::#{module_name}
end
EOC

File.open("test_file.rb","w") do |file|
   file.puts out
end