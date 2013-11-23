require "xlgrep/version"

module Xlgrep

  autoload :Context    , "xlgrep/context"
  autoload :InvalidJson, "xlgrep/invalid_json"
  autoload :SimpleFormatter, "xlgrep/simple_formatter"

  class << self
    def method_missing(name, *args, &block)
      mod = name.to_s.split(/_/).map(&:capitalize).join
      if const_defined?(mod)
        run([const_get(mod)], *args, &block)
      else
        super
      end
    end

    def run(predicates, files)
      Context.new(predicates).execute(files)
    end
  end

end
