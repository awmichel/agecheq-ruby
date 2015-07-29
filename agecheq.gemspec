$LOAD_PATH.push File.expand_path('../lib', __FILE__)

require 'agecheq/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'agecheq'
  s.version     = AgeCheq::VERSION
  s.licenses    = ['MIT']
  s.authors     = ['Quirky Development', 'Adam Michel']
  s.email       = ['platform@quirky.com', 'amichel@quirky.com']
  s.homepage    = 'https://www.quirky.com'
  s.summary     = "AgeCheq is a thin Ruby wrapper around the AgeCheq API."
  s.description = "AgeCheq is a thin Ruby wrapper around the AgeCheq API."

  s.files = Dir['{lib}/**/*', 'Rakefile', 'README.md']

  s.add_dependency 'httparty'
  s.add_dependency 'activesupport', '> 4.0'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'faker'
end
