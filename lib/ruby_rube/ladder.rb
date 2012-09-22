module RubyRube
  # The ladder is an array that is the length of the input string.
  # Initially the string is assigned to the first array item.  The message is
  # moved from each position in the array to the next position until the array has
  # no more positions. When the message gets to the top of the ladder it jumps off....
  class Ladder
    attr_accessor :ladder
    attr_reader :contestant

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
end
