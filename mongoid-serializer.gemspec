# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongoid/serializer/version'

Gem::Specification.new do |spec|
  spec.name          = "mongoid-serializer"
  spec.version       = Mongoid::Serializer::VERSION
  spec.authors       = ["Kristian Mandrup"]
  spec.email         = ["kmandrup@gmail.com"]
  spec.description   = %q{Adds some sane controller serialization support of your Mongoid models}
  spec.summary       = %q{Mongoid serialization support for server APIs}
  spec.homepage      = "https://github.com/kristianmandrup/mongoid-serializer"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'mongoid', '>= 3.0'
  spec.add_dependency 'active_model-shaz'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
