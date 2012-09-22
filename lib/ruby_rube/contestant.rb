module RubyRube
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
        ObstacleFactory.get(self, k.to_s).start
      end
      puts 'Contestent runs to to the podeum to bring his message to the world...'
      podeum = Podeum.new(self)
      podeum.present
    end
  end
end
