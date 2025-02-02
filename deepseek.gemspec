require_relative 'lib/deepseek/version'

Gem::Specification.new do |spec|
  spec.name          = "deepseek"
  spec.version       = Deepseek::VERSION
  spec.authors       = ["Nagendra Dhanakeerthi"]
  spec.email         = ["nagendra.dhanakeerthi@gmail.com"]

  spec.summary       = "Ruby SDK for Deepseek AI API"
  spec.description   = "A comprehensive Ruby client library for interacting with Deepseek's AI APIs, " \
                      "providing a simple and intuitive interface for making API calls, handling responses, " \
                      "and managing API resources."
  spec.homepage      = "https://github.com/nagendrakdangi/deepseek-ruby"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata = {
    "homepage_uri" => spec.homepage,
    "source_code_uri" => spec.homepage,
    "changelog_uri" => "#{spec.homepage}/blob/main/CHANGELOG.md",
    "documentation_uri" => "#{spec.homepage}/blob/main/README.md",
    "bug_tracker_uri" => "#{spec.homepage}/issues"
  }

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir[
    "lib/**/*",
    "CHANGELOG.md",
    "LICENSE.txt",
    "README.md",
    "bin/*"
  ]
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Runtime dependencies
  spec.add_dependency "faraday", "~> 2.0"
  spec.add_dependency "faraday-retry", "~> 2.0"

  # Development dependencies
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 3.0"
  spec.add_development_dependency "simplecov", "~> 0.22.0"
  spec.add_development_dependency "simplecov-cobertura", "~> 2.1"
  spec.add_development_dependency "rubocop", "~> 1.0"
  spec.add_development_dependency "yard", "~> 0.9"
  spec.add_development_dependency "pry", "~> 0.14"
end