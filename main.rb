#!/usr/env ruby

require 'optparse'

class DataValidator
  class << self
    def validate(string)
      raise ArgumentError, 'You must supply an argument.  Please re-run the program supplying an argument.' if string.nil?
    end
  end
end

class Path
  attr_accessor :path
  def initialize(path=1)
    @path = path
  end
end

class OutputWriter
  # Interface takes a DataString instance
  def initialize(data_string)
    @name = data_string
  end
  def print_simple
    p "Hello #{@name.data_string}"
  end
  def print_complex
  end
end

class ParsedOptions
  attr_reader :options
  def initialize
    @options = {}
    optparse = OptionParser.new do |opts|
      opts.banner = "Usage: optparse1.rb [options] file1 file2 ..."
      @options[:path] = nil
      opts.on( '-p', '--path PATH', 'Select which path to run') do |path|
        @options[:path] = path.to_i
      end
    end
    optparse.parse!
    puts "We are running path #{@options[:path]}" if @options[:path]
  end
end

class Rube
  def run
    cmd_opts = ParsedOptions.new()
    case cmd_opts.options[:path]
    when 1
      # For this path we need to have an argument supplied on the command line
      DataValidator.validate(ARGV[0])
      OutputWriter.new(ARGV[0]).print_simple
    when 2
      OutputWriter.new('you awesome Rubyist!').print_simple
    end
  end
end

Rube.new.run
