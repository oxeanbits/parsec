# simplecov-shields-badge

# Examples

[![Coverage 20%](https://img.shields.io/badge/coverage-20%25-red.svg)](https://github.com/niltonvasques/simplecov-shields-badge)
[![Coverage 40%](https://img.shields.io/badge/coverage-40%25-orange.svg)](https://github.com/niltonvasques/simplecov-shields-badge)
[![Coverage 60%](https://img.shields.io/badge/coverage-60%25-yellow.svg)](https://github.com/niltonvasques/simplecov-shields-badge)
[![Coverage 80%](https://img.shields.io/badge/coverage-80%25-yellowgreen.svg)](https://github.com/niltonvasques/simplecov-shields-badge)
[![Coverage 90%](https://img.shields.io/badge/coverage-90%25-green.svg)](https://github.com/niltonvasques/simplecov-shields-badge)
[![Coverage 100%](https://img.shields.io/badge/coverage-100%25-brightgreen.svg)](https://github.com/niltonvasques/simplecov-shields-badge)


## Usage

> Add to your `Gemfile`

```ruby
group :test do
  gem 'simplecov-shields-badge', require: false
end
```

> Add to your README.md

> Add to the top of your `tests/helper.rb` file

```ruby
require 'simplecov'
SimpleCov.start

require 'shields_badge'
SimpleCov.formatter = SimpleCov::Formatter::ShieldsBadge
```

> In your CI Environment Variables

```sh
GITHUB_USER="a github username"
GITHUB_MAIL="github user email"
GITHUB_ORG="github organization or username"
GITHUB_REPO="github repo name"
GITHUB_ACCESS_TOKEN="github access token with commit permission"
```

