# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dlm_now_showing/version'

Gem::Specification.new do |spec|
  spec.name          = "dlm_now_showing"
  spec.version       = DlmNowShowing::VERSION
  spec.authors       = ["Dakota Martinez"]
  spec.email         = ["dakotaleemusic@gmail.com"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  end

  spec.summary       = "Installs a command line interface for checking movie showtimes in your area"
  spec.description   = "Search your area for movies playing nearby. Filter your search by theatre, genre, or movie!"
  spec.homepage      = "https://github.com/DakotaLMartinez/dlm_now_showing"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
end
