require 'aws/pws'
require 'aws/pws/credential_provider'

module Omnivault
  class PWS < AbstractVault
    attr_accessor :client

    def entries
      @client ||= AWS::PWS::Client.new
      Hash[@client.raw_data.map { |k, v| [k, v[:password]] }]
    end

    def fetch(key)
      entries[key]
    end

    def store(key, value)
      @client ||= AWS::PWS::Client.new
      @client.cli.add(key, value)
    end

    def configure_aws!
      provider = AWS::PWS::CredentialProvider.new
      AWS.config(credential_provider: provider)
    end
  end
end
