module RubyRube
  class ObstacleFactory
    class << self
      def get(contestant, obstacle)
        class_name = obstacle.split('_').select {|w| w.capitalize! || w }.join('')
        RubyRube.const_get(class_name).new(contestant)
      end
    end
  end
end
