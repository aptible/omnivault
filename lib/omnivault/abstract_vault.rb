module Omnivault
  class AbstractVault
    def self.from_env(name = 'default')
      case ENV['VAULT']
      when 'apple', 'keychain', 'AppleKeychain'
        AppleKeychain.new(name)
      when 'pws', 'PWS'
        PWS.new(name)
      end
    end

    def self.for_platform(name = 'default')
      if (/darwin/ =~ RUBY_PLATFORM).nil?
        PWS.new(name)
      else
        AppleKeychain.new(name)
      end
    rescue LoadError => e
      puts e.message
      puts e.backtrace
      PWS.new(name)
    end

    # Either aws-sdk and/or aws-sdk-v1 must be required BEFORE calling
    # Omnivault::AbstractVault#configure_aws!
    def configure_aws!
      if defined?(Aws)
        require_relative 'v2_credential_provider'

        provider = V2CredentialProvider.new(self)
        Aws.config[:credentials] = provider
      end

      if defined?(AWS)
        require_relative 'v1_credential_provider'

        provider = V1CredentialProvider.new(self)
        AWS.config(credential_provider: provider)
      end
    end

    def initialize(_name = 'default')
      raise NotImplementedError, 'Must invoke from subclass'
    end

    def entries
      raise NotImplementedError, 'Must invoke from subclass'
    end

    def fetch(key)
      entries[key]
    end

    def store(_key, _value)
      raise NotImplementedError, 'Must invoke from subclass'
    end

    def remove(_key)
      raise NotImplementedError, 'Must invoke from subclass'
    end
  end
end
