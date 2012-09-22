module RubyRube
  # The path that the Contestant will follow
  class Path
    attr_accessor :obstacles
    def initialize(obstacles)
      @obstacles = obstacles
    end
  end
end
