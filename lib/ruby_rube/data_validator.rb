module RubyRube
  class DataValidator
    class << self
      def validate(string)
        raise ArgumentError, 'You must supply an argument.  Please re-run the program supplying an argument.' if string.nil?
      end
    end
  end
end
