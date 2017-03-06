# Omnivault

[![Gem Version](https://badge.fury.io/rb/omnivault.png)](https://rubygems.org/gems/omnivault)
[![Build Status](https://travis-ci.org/aptible/omnivault.png?branch=master)](https://travis-ci.org/aptible/omnivault)
[![Dependency Status](https://gemnasium.com/aptible/omnivault.png)](https://gemnasium.com/aptible/omnivault)

A Ruby library and CLI tool to abstract keychain functionality for storing and retrieiving arbitrary secrets from a variety of password vaults.

Omnivault supports simple key-value secret retrieval with the following password vaults:

* Apple OS X Keychain
* pws (a CLI-based vault)

Additionally, it supports automatic credential setup for the following libraries:

* AWS Ruby SDK (`aws-sdk-v1`, `aws-sdk`)

## Installation and Usage (CLI Tool)

To install for CLI usage, simply run `gem install omnivault` and then refer to `omnivault help` for usage:

```
Commands:
  omnivault env [-v VAULT]                                # Print secret values from vault as source-able ENV variables
  omnivault exec [-v VAULT] COMMAND                       # Execute command with secret values as ENV variables
  omnivault help [COMMAND]                                # Describe available commands or one specific command
  omnivault ls [-v VAULT]                                 # List all secret keys from vault
  omnivault set [-v VAULT] KEY1=value1 [KEY2=value2 ...]  # Set one or more secret values in vault
  omnivault unset [-v VAULT] KEY1 [KEY2 ...]              # Unset one or more secret values in vault
```

## Installation (Library)

Add the following line(s) to your application's Gemfile.

    gem 'omnivault'

And then run `bundle install`.

## Usage (Library)

To initialize the the Omnivault, run:

```ruby
omnivault = Omnivault.autodetect
```

This will determine an appropriate provider using the following logic:

* If the ENV variable `VAULT` is set, it will use that provider, i.e.,
  - Apple Keychain for `VAULT=apple`
  - PWS for `VAULT=pws`
* If no ENV variable is set, it will try to use Apple Keychain first on OS X, then PWS. If not on OS X only PWS will be
used.

Then, to use Omnivault, you can:

```ruby
omnivault.store('foo', 'bar')
omnivault.entries
# => { "foo" => "bar" }
omnivault.fetch("foo")
# => "bar"
```

## AWS Setup

Omnivault provides a `configure_aws!` method, which can be used to automatically load credentials in the context of the [AWS SDK for Ruby](https://aws.amazon.com/sdk-for-ruby/).

```ruby
omnivault.configure_aws!
```

To use this feature, you'll need to set the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` secrets in Omnivault:

```
omnivault set AWS_ACCESS_KEY_ID=... AWS_SECRET_ACCESS_KEY=...
```


## Contributing

1. Fork the project.
1. Commit your changes, with specs.
1. Ensure that your code passes specs (`rake spec`) and meets Aptible's Ruby style guide (`rake rubocop`).
1. Create a new pull request on GitHub.

## Copyright and License

MIT License, see [LICENSE](LICENSE.md) for details.

Copyright (c) 2017 [Aptible](https://www.aptible.com), Frank Macreery, and contributors.

[<img src="https://s.gravatar.com/avatar/f7790b867ae619ae0496460aa28c5861?s=60" style="border-radius: 50%;" alt="@fancyremarker" />](https://github.com/fancyremarker)
