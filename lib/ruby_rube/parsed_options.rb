module RubyRube
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
end
