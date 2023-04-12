source "https://rubygems.org"

gem "rake"

group :development do
  gem "pry"
  gem "pry-byebug"
end

group :test do
  gem "rspec", ">= 3.2"
  gem "webmock", '~> 3.14.0' if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("2.4.0")
  gem "webmock", '>= 3.14' if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new("2.4.0")
end

gemspec
