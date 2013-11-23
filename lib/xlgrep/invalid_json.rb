require 'json'

module Xlgrep
  module InvalidJson
    class << self

      def match(str)
        if str =~ /\A[\s\n\r]*(?:\{.*\}|\[.*\])[\s\n\r]*\Z/
          begin
            JSON.parse(str.strip)
          rescue JSON::ParserError => e
            yield(e.message)
          end
        end
      end

    end
  end
end
