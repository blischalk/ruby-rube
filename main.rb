#!/usr/env ruby

require 'optparse'

class DataValidator
  class << self
    def validate(string)
      raise ArgumentError, 'You must supply an argument.  Please re-run the program supplying an argument.' if string.nil?
    end
  end
end

# The path that the Contestant will follow
class Path
  attr_accessor :obstacles
  def initialize(obstacles)
    @obstacles = obstacles
  end
end

# The object that is following the path of the machine
class Contestant
  attr_accessor :obstacle, :completed_obstacles, :path
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

  def run(path)
    @path = path
    @path.obstacles.each do |k, v|
      Obstacle.get(self, k.to_s).start
    end
    puts 'Contestent runs to to the podeum to bring his message to the world...'
    podeum = Podeum.new(self)
    podeum.present
  end
end

# Where the Contestant will end up to deliver the message
class Podeum
  # Interface takes a DataString instance
  def initialize(contestant)
    @contestant = contestant
  end
  def present
    puts "#{@contestant.speech}"
  end
end

class Obstacle
  attr_reader :contestant
  attr_accessor :get
  class << self
    def get(contestant, obstacle)
      class_name = obstacle.split('_').select {|w| w.capitalize! || w }.join('')
      Object.const_get(class_name).new(contestant)
    end
  end
end

# The ladder is an array that is the length of the input string.
# Initially the string is assigned to the first array item.  The message is
# moved from each position in the array to the next position until the array has
# no more positions. When the message gets to the top of the ladder it jumps off....
class Ladder < Obstacle
  attr_accessor :ladder

  def initialize(contestant)
    @contestant = contestant
    p 'Contestent runs to the first obstacle... The Ladder'
    setup_ladder(@contestant.message)
    @contestant.completed_obstacles += 1
  end

  def setup_ladder(message)
    @ladder = Array.new(message.length)
  end

  def start
    @ladder.each_with_index do |v, i|
      @ladder[i] = @contestant.message
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

# Program Class
# Welcome to the machine...
class Rube
  def run
    cmd_opts = ParsedOptions.new()
    case cmd_opts.options[:path]
    when 1
      # For this path we need to have an argument supplied on the command line
      DataValidator.validate(ARGV[0])
      # Acquire a contestant to run the path
      contestant = Contestant.new(ARGV[0])
      # Get the path the contestent will follow complete with obstacles
      path = Path.new({ladder: 0})
      # Set the contestant running the path
      contestant.run(path)
      
    when 2
      puts 'You awesome Rubyist!'
    end
  end
end

# Start the Machine
Rube.new.run
