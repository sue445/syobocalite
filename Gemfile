source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in syobocalite.gemspec
gemspec

if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("3.2.0")
  # NOTE: i18n 1.15.0+ requires Ruby 3.2+
  gem "i18n", "< 1.15.0"
end
