# -*- encoding: utf-8 -*-
# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "postler/version"

Gem::Specification.new do |gem|
  gem.authors       = ["denic"]
  gem.email         = ["info@buecker-it.de"]
  gem.description   = "Add microposts to your mongodb based ruby project."
  gem.summary       = ""
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "postler"
  gem.require_paths = ["lib"]
  gem.version       = Postler::VERSION

  gem.add_development_dependency "rspec", "~> 2.5"
  gem.add_development_dependency "database_cleaner", "~> 0.8"
  gem.add_development_dependency "mongoid", "~> 2.4"
  gem.add_development_dependency "bson_ext", "~> 1.5"
  gem.add_development_dependency "rake"
end
