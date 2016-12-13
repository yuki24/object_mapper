# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'object_mapper/version'

Gem::Specification.new do |spec|
  spec.name          = "object_mapper"
  spec.version       = ObjectMapper::VERSION
  spec.authors       = ["Yuki Nishijima"]
  spec.email         = ["mail@yukinishijima.net"]

  spec.summary       = %q{Object Mapper in Ruby}
  spec.description   = %q{Convert JSON to Plain Old Ruby Objects.}
  spec.homepage      = "https://github.com/yuki24"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0").reject {|f| f.match(%r{^test/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.2.0'

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end
