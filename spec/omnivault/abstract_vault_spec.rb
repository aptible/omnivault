require 'spec_helper'

describe Omnivault::AbstractVault do
  before do
    # Override parent class initialization exception in tests
    described_class.send(:define_method, :initialize) {}
  end

  describe '#configure_aws!' do
    before do
      allow(subject).to receive(:entries) do
        {
          'AWS_ACCESS_KEY_ID' => 'id',
          'AWS_SECRET_ACCESS_KEY' => 'secret'
        }
      end
    end

    it 'configures credentials for aws-sdk-v1' do
      require 'aws-sdk-v1'
      subject.configure_aws!
      v1_credentials = AWS.config.credential_provider.credentials
      expect(v1_credentials[:access_key_id]).to eq 'id'
      expect(v1_credentials[:secret_access_key]).to eq 'secret'
    end

    it 'configures credentials for aws-sdk-v2' do
      require 'aws-sdk'
      subject.configure_aws!

      v2_credentials = Aws.config[:credentials].credentials
      expect(v2_credentials.access_key_id).to eq 'id'
      expect(v2_credentials.secret_access_key).to eq 'secret'
    end
  end
end
