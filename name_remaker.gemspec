
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "name_remaker/version"

Gem::Specification.new do |spec|
  spec.name          = "name_remaker"
  spec.version       = NameRemaker::VERSION
  spec.authors       = ["Frank Pimenta"]
  spec.email         = ["frank.pimenta@swisslife-select.ch"]

  spec.summary       = %q{provides several operations over a (full) name}
  spec.description   = %q{
    The goal of this gem is to provide a means to manage full names, like
    providing a list of names shortened to X chars
  }
  spec.homepage      = "https://gitlab.slsag.ch/gems/name_remaker"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "git@gitlab.slsag.ch:gems/name_remaker.git"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
end
