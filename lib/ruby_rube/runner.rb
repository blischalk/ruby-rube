require 'optparse'
require_relative 'parsed_options'
require_relative 'ladder'
require_relative 'obstacle_factory'
require_relative 'data_validator'
require_relative 'contestant'
require_relative 'path'
require_relative 'podeum'
module RubyRube
  # Program Class
  # Welcome to the machine...
  class Runner
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
end
