Gem::Specification.new do |spec|
  spec.name        = 'imei-scrapper'
  spec.version     = '0.0.1'
  spec.date        = '2015-06-02'
  spec.summary     = 'Apple IMEI scrapper'
  spec.description = 'Apple IMEI scrapper'
  spec.authors     = ['Andrey Chernyshev']
  spec.email       = 'libdual@yandex.ru'
  spec.homepage    = 'http://rubygems.org/gems/imei-scrapper'
  spec.license       = 'MIT'
  spec.executables = ['imei-scrapper']
  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'webmock'
end