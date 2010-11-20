source 'http://rubygems.org'

gem 'rake'

ruby_version = RUBY_VERSION.split('.')
is_1_9 = ruby_version[0] == '1' and ruby_version[1] == '9'

group :development do
  gem 'autotest'
  gem 'autotest-fsevent'
  gem is_1_9 ? 'ruby-debug19' : 'ruby-debug'
end

group :doc do
  gem 'bluecloth'
  gem 'yard'
end

group :spec do
  gem 'rspec'
end
