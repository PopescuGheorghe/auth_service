require 'spec_helper'

describe AuthKey do
  context 'description' do
    it { is_expected.to respond_to(:token) }
    it { is_expected.to respond_to(:token_created_at) }
    # it { is_expected.to validate_presence_of(:token) }
    # it { is_expected.to validate_presence_of(:token_created_at) }
    # it { is_expected.to validate_uniqueness_of(:token) }
  end
  context 'generate_authnetication_token' do
    it 'does something' do
      allow(Digest::SHA1).to receive(:hexdigest).and_return 'token123'
      expect(AuthKey.generate_authentication_token).to eql 'token123'
    end
  end
end
