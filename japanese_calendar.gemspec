# frozen_string_literal: true

lib = File.expand_path('lib')
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'japanese_calendar/version'

Gem::Specification.new do |spec|
  spec.name          = "japanese_calendar"
  spec.version       = JapaneseCalendar::VERSION
  spec.authors       = ["Ryo Yamamoto"]
  spec.email         = ["email@ryoyamamoto.jp"]

  spec.summary       = "Japanese calendar utility for Ruby"
  spec.homepage      = "https://github.com/RyoYamamotoJP/japanese_calendar"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.3"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "codeclimate-test-reporter", "~> 1.0.0"
end
