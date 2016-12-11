module Omnivault
  class AppleKeychain < AbstractVault
    attr_accessor :keychain

    def initialize(name = 'default')
      # Need to require within initializer, to avoid LoadError on
      # non-Apple platforms
      require 'keychain'

      @keychain = open_or_create_keychain(name)
    end

    def entries
      Hash[keychain.generic_passwords.all.map do |item|
        [item.label, item.password]
      end]
    end

    def store(key, value)
      if (entry = keychain.generic_passwords.where(label: key).all.first)
        entry.password = value
        entry.save!
      else
        keychain.generic_passwords.create(
          service: key,
          label: key,
          password: value
        )
      end
    end

    def remove(key)
      entry = keychain.generic_passwords.where(label: key).all.first
      entry.delete
    end

    private

    def open_or_create_keychain(name)
      keychain = Keychain.open("omnivault-#{name}.keychain")
      return keychain if keychain.exists?

      Keychain.create("omnivault-#{name}.keychain")
    end
  end
end
