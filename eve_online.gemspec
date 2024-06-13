# frozen_string_literal: true

require_relative "lib/eve_online/version"

Gem::Specification.new do |spec|
  spec.name = "eve_online"
  spec.version = EveOnline::VERSION
  spec.authors = ["Ihor Zubkov"]
  spec.email = ["igor.zubkov@gmail.com"]

  spec.summary = "EveOnline ESI API"
  spec.description = "EveOnline ESI API."
  spec.homepage = "https://github.com/evemonk/eve_online"
  spec.license = "MIT"

  spec.metadata = {
    "rubygems_mfa_required" => "true",
    "bug_tracker_uri" => "https://github.com/evemonk/eve_online/issues",
    "changelog_uri" => "https://github.com/evemonk/eve_online/blob/main/CHANGELOG.md",
    "documentation_uri" => "https://github.com/evemonk/eve_online/blob/main/README.md",
    "homepage_uri" => "https://github.com/evemonk/eve_online",
    "source_code_uri" => "https://github.com/evemonk/eve_online"
  }

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features|bin|swagger)/}) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 3.1"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-its"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "vcr"

  spec.add_runtime_dependency "base64"
  spec.add_runtime_dependency "faraday", ">= 2.3.0"
  spec.add_runtime_dependency "activesupport", ">= 7.0.0"
end
