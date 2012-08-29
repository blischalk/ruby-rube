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

class Contestant
  attr_accessor :obstacle
  attr_accessor :completed_obstacles
  attr_reader :message
  def initialize(message)
    @message=message
    @obstacle = @completed_obstacles = 0
  end
  def speech
    puts 'Greetings to all'
    puts @message
    puts "I have conquered #{completed_obstacles} obstacle(s) to be here"
  end
end

class Podeum
  # Interface takes a DataString instance
  def initialize(contestant)
    @contestant = contestant
  end
  def present
    puts "#{@contestant.speech}"
  end
end

# The ladder is an array that is the length of the input string.
# Initially the string is assigned to the first array item.  The message is
# moved from each position in the array to the next position until the array has
# no more positions. When the message gets to the top of the ladder it jumps off....
class Ladder
  attr_reader :contestant
  def initialize(contestant)
    @contestant = contestant
    @message = @contestant.message
    setup_ladder(@message)
    @contestant.completed_obstacles += 1
  end
  def setup_ladder(message)
    @message_length = message.length
    @ladder = Array.new(@message_length)
    @ladder.each_with_index do |v, i|
      @ladder[i] = message
      @ladder[i - 1] = nil unless i == 0
      p "Climed on to step #{i +1} of the ladder"
    end
    p 'Ahhhhhhh...... (Jumped off the ladder)'
  end
end

class ParsedOptions
  attr_reader :options
  def initialize
    @options = {}
    optparse = OptionParser.new do |opts|
      opts.banner = "Usage: optparse1.rb [options] file1 file2 ..."
      @options[:path] = 1
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
      contestant = Contestant.new(ARGV[0])
      puts 'Contestent runs to the first obstacle... The Ladder'
      ladder = Ladder.new(contestant)
      puts 'Contestent runs to to the podeum to bring his message to the world...'
      podeum = Podeum.new(contestant)
      podeum.present
    when 2
      OutputWriter.new('you awesome Rubyist!').print_simple
    end
  end
end

Rube.new.run
