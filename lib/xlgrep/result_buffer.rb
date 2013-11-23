require 'xlgrep'

module Xlgrep
  class ResultBuffer

    attr_reader :result
    def initialize
      @result = []
    end

    def process(obj)
      @result << obj
    end
  end
end
