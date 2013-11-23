require 'xlgrep'

module Xlgrep
  class SimpleFormatter
    def initialize(io = nil)
      @io = io || $stdout
    end

    def process(obj)
      @io.puts "-" * 80
      @io.puts "file    : " << obj[:file]
      @io.puts "sheet   : " << obj[:sheet]
      @io.puts "position: " << obj[:x] << obj[:y].to_s
      @io.puts "cell    : " << obj[:data]
      @io.puts "msg     : " << obj[:msg]
    end
  end
end
