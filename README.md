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

## Usage

To initialize the the Omnivault, run:

```ruby
omnivault = Omnivault.autodetect
```

This will determine an appropriate provider using the following logic:

* If the ENV variable `VAULT` is set, it will use that provider, i.e.,
  - Apple Keychain for `VAULT=apple`
  - PWS for `VAULT=pws`
* If no ENV variable is set, it will try to use Apple Keychain first, and fall back to PWS if not on Apple OS X.

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

To use this feature, you'll need to set up `aws-keychain-util` or `aws-pws`. With either approach, you can also (optionally) create a new `aws` shell command which wraps the original [AWS CLI](https://aws.amazon.com/cli/) to provide authenticated access to your AWS credentials.

### Apple Keychain

To set up AWS credentials using `aws-keychain-util`:

1. `gem install -N aws-keychain-util`
2. `aws-creds init`
3. `aws-creds add`

    - Use 'default' for the account name
    - Leave the MFA ARN blank

4. (Optional) Add the following file as `aws` somewhere on your `PATH` with higher precedence than `/usr/local/bin`. (`$HOME/.bin` is a good choice.) Make it executable by running `chmod +x aws-safe`.

        #!/bin/bash
        # $HOME/.bin/aws

        set -e

        export $(aws-creds cat default)
        /usr/local/bin/aws $@


### PWS

On Linux, you can use PWS instead:

1. `gem install -N aws-pws`
2. `aws-pws init`
3. (Optional) Add the following file as `aws` somewhere on your `PATH` with higher precedence than `/usr/local/bin`.

        #!/bin/bash
        # $HOME/.bin/aws

        set -e

        export $(aws-pws cat)
        /usr/local/bin/aws $@

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
