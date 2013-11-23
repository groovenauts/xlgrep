require 'xlgrep'

require 'json'

module Xlgrep
  class Regexp
    def initialize(expression)
      @impl = /#{expression}/
    end

    def match(str)
      if str =~ @impl
        yield("MATCH")
      end
    end
  end
end
