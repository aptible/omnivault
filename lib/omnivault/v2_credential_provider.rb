require 'aws-sdk'

module Omnivault
  class V2CredentialProvider
    include Aws::CredentialProvider

    attr_accessor :vault

    def initialize(vault)
      @vault = vault
    end

    def credentials
      Aws::Credentials.new(vault.fetch('AWS_ACCESS_KEY_ID'),
                           vault.fetch('AWS_SECRET_ACCESS_KEY'))
    end
  end
end
