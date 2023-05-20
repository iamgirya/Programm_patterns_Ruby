# frozen_string_literal: true

require_relative "lib/rybish_code/version"

Gem::Specification.new do |spec|
  spec.name = "rybish_code"
  spec.version = RybishCode::VERSION
  spec.authors = ["Girya"]
  spec.email = ["nullexp.team@gmail.com"]
  spec.summary = "Student App"
  spec.description = "А gem that allows you to get pass for patterns"
  spec.homepage = "https://github.com/Jakepps"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"
  spec.add_dependency 'win32api'
  spec.files = Dir.glob("**/*")
end
