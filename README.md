# Omnivault

[![Gem Version](https://badge.fury.io/rb/omnivault.png)](https://rubygems.org/gems/omnivault)
[![Build Status](https://travis-ci.org/aptible/omnivault.png?branch=master)](https://travis-ci.org/aptible/omnivault)
[![Dependency Status](https://gemnasium.com/aptible/omnivault.png)](https://gemnasium.com/aptible/omnivault)

A Ruby library to abstract keychain functionality for storing and retrieiving arbitrary secrets from a variety of password vaults.

Omnivault supports simple key-value secret retrieval with the following password vaults:

* Apple OS X Keychain
* pws (a CLI-based vault)

Additionally, it supports automatic credential setup for the following libraries:

* AWS Ruby SDK (`aws-sdk-v1`, `aws-sdk`)

## Installation

Add the following line to your application's Gemfile.

    gem 'omnivault'

And then run `bundle install`.

## TODO

* Add support for 1Password keychains.
* Write RSpec unit tests.
* Remove dependence on AWS-specific gems directly

## Contributing

1. Fork the project.
1. Commit your changes, with specs.
1. Ensure that your code passes specs (`rake spec`) and meets Aptible's Ruby style guide (`rake rubocop`).
1. Create a new pull request on GitHub.

## Copyright and License

MIT License, see [LICENSE](LICENSE.md) for details.

Copyright (c) 2015 [Aptible](https://www.aptible.com), Frank Macreery, and contributors.

[<img src="https://s.gravatar.com/avatar/f7790b867ae619ae0496460aa28c5861?s=60" style="border-radius: 50%;" alt="@fancyremarker" />](https://github.com/fancyremarker)
