module RubyRube
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
end
