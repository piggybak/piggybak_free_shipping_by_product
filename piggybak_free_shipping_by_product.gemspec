$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "piggybak_free_shipping_by_product/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "piggybak_free_shipping_by_product"
  s.version     = PiggybakFreeShippingByProduct::VERSION
  s.authors     = ["Steph Skardal"]
  s.email       = ["steph@endpoint.com"]
  s.homepage    = "http://www.endpoint.com/"
  s.summary     = "Free shipping in Piggybak, depending on a product / sellable method as defined in the configuration."
  s.description = "Free shipping in Piggybak, depending on a product / sellable method as defined in the configuration."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_development_dependency "rails", "4.1.3"
  s.add_development_dependency "devise", '3.2.4'
  s.add_development_dependency "piggybak", "0.7.4"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rails_admin", "0.6.2" 
end
