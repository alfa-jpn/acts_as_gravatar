# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'acts_as_gravatar/version'

Gem::Specification.new do |spec|
  spec.name          = "acts_as_gravatar"
  spec.version       = ActsAsGravatar::VERSION
  spec.authors       = ["Atsushi Nakamura"]
  spec.email         = ["a.nkmr.ja@gmail.com"]
  spec.description   = "acts_as_gravatar provide simple access to gravatar from ActiveRecord.Can interoperate with devise, etc.."
  spec.summary       = "acts_as_gravatar provide simple access to gravatar from ActiveRecord.Can interoperate with devise, etc.."
  spec.homepage      = "https://github.com/alfa-jpn/acts_as_gravatar"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "rspec", "~> 2.14.1"
  spec.add_development_dependency "yard", "~> 0.8.7.3"

  spec.add_dependency "inum", "~> 2.0.0"
  spec.add_dependency "activerecord"
end
