#!/usr/env ruby

class DataValidator
  class << self
    def validate(string)
      raise ArgumentError, 'You must supply an argument.  Please re-run the program supplying an argument.' if string.nil?
    end
  end
end

class DataString
  attr_accessor :data_string
  def initialize(input_string)
    DataValidator.validate(input_string)
    @data_string = input_string
  end
end

class OutputWriter
  # Interface takes a DataString instance
  def initialize(data_string)
    @name = data_string
  end
  def print_output
    p "Hello #{@name.data_string}"
  end
end

OutputWriter.new(DataString.new(ARGV[0])).print_output
