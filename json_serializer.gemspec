$:.push File.expand_path("../lib", __FILE__)
require "json_serializer/version"
Gem::Specification.new do |s|
  s.name        = "json_serializer"
  s.version     = JSONSerializer::VERSION
  s.authors     = ["Antonio Chavez"]
  s.email       = ["antonio@queuetechnologies.com"]
  s.homepage    = "https://github.com/QueueTechnologies/json_serializer"
  s.summary     = "Plain Old Ruby Objects json serializer for API's"
  s.description = "Easy JSON serializer for PORO objects that is compatible with rails."
  s.licenses    = "MIT"

  s.files = Dir["{lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_runtime_dependency "rails", "~> 4.1"

  # Rspec testing framework
  s.add_development_dependency "rspec"
end
