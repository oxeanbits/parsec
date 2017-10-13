# simplecov-shields-badge

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

require 'codecov'
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

