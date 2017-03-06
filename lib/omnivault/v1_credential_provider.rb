require 'aws-sdk-v1'

module Omnivault
  class V1CredentialProvider
    include AWS::Core::CredentialProviders::Provider

    attr_accessor :vault

    def initialize(vault)
      @vault = vault
    end

    # rubocop:disable AccessorMethodName
    def get_credentials
      {
        access_key_id: vault.fetch('AWS_ACCESS_KEY_ID'),
        secret_access_key: vault.fetch('AWS_SECRET_ACCESS_KEY')
      }
    end
    # rubocop:enable AccessorMethodName
  end
end
