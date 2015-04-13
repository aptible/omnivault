module Omnivault
  class AppleKeychain < AbstractVault
    def initialize
      # Need to require within initializer, to avoid LoadError on
      # non-Apple platforms
      require 'keychain'
      require 'aws-keychain-util/credential_provider'
    end

    def entries
      keychain = open_or_create_keychain
      Hash[keychain.generic_passwords.all.map do |item|
        [item.label, item.password]
      end]
    end

    def fetch(key)
      entries[key]
    end

    def store(key, value)
      keychain = open_or_create_keychain
      if (entry = keychain.generic_passwords.where(label: key).all.first)
        entry.password = value
      else
        keychain.generic_passwords.create(
          service: key,
          label: key,
          password: value
        )
      end
    end

    def configure_aws!
      provider = ::AwsKeychainUtil::CredentialProvider.new('default', 'aws')
      AWS.config(credential_provider: provider)
    end

    private

    def open_or_create_keychain(name = 'aptible-cookbook')
      keychain = Keychain.open("#{name}.keychain")
      return keychain if keychain.exists?

      Keychain.create("#{name}.keychain")
    end
  end
end
