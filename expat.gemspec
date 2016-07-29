$:.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'expat'
  s.version     = '0.1.0'
  s.authors     = ['Frank Groeneveld']
  s.email       = ['frank@ivaldi.nl']
  s.homepage    = 'https://github.com/ivaldi/expat/'
  s.summary     = 'Manage your i18n yaml files using a simple web interface'
  s.description = 'Expat adds a mountable web application to your ' +
      'development environment that will enable you to manage the i18n yaml ' +
      'files of your Rails application.'
  s.license     = 'BSD-2-Clause'

  s.files = Dir['{app,config,db,lib}/**/*', 'LICENSE', 'Rakefile']

  s.add_dependency 'rails', '>= 4.1.0', '< 6'

  s.add_development_dependency 'sqlite3', '~> 1.3'
end
