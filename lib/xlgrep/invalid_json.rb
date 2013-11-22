require 'json'

module Xlgrep
  module InvalidJson
    class << self

      def match(str)
        if str =~ /\A\{.*\}\Z|\A\[.*\]\Z/
          begin
            JSON.parse(str)
          rescue JSON::ParserError => e
            yield(e.message)
          end
        end
      end

    end
  end
end
