# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xlgrep/version'

Gem::Specification.new do |spec|
  spec.name          = "xlgrep"
  spec.version       = Xlgrep::VERSION
  spec.authors       = ["akima"]
  spec.email         = ["akm2000@gmail.com"]
  spec.description   = %q{support to grep something in .xlsx files}
  spec.summary       = %q{support to grep something in .xlsx files}
  spec.homepage      = "https://github.com/groovenauts/xlgrep"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "roo", "~> 1.12.2"
  spec.add_runtime_dependency "highline"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
