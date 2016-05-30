require 'spec_helper'

describe AuthorizationController, type: :controller do
  context '.check_authorization' do
    it 'renders proper data for authorized' do
      key = FactoryGirl.create :auth_key
      request.headers['Authorization'] = key.token
      post :check_authorization
      parsed_response = JSON.parse(response.body)
      expect(response.status).to eql 200
    end

    it 'renders proper data for unauthorized' do
      post :check_authorization
      parsed_response = JSON.parse(response.body)
      expect(response.status).to eql 401
    end

    it 'invalidates token after 24 hours' do
      key = FactoryGirl.create :auth_key
      request.headers['Authorization'] = key.token
      Timecop.travel(Time.now + 1.day)
      post :check_authorization
      parsed_response = JSON.parse(response.body)
      expect(response.status).to eql 401
      Timecop.return
    end
  end

  context '.create' do
    it 'generates a new token' do
      allow(AuthKey).to receive(:generate_authentication_token).and_return 'token123'
      expected_response = {
        'success' => true,
        'data' => {
          'token' => 'token123'
        }
      }
      post :create, id: 1
      parsed_response = JSON.parse(response.body)
      expect(response.status).to eql 201
      expect(parsed_response).to eql expected_response
    end

    it 'render erros if record invalid' do
      key = FactoryGirl.create :auth_key, token: 'token123'
      allow(AuthKey).to receive(:generate_authentication_token).and_return 'token123'
      expected_response = {
        'success' => false,
        'errors' => ['token has already been taken']
      }
      post :create, id: 2
      parsed_response = JSON.parse(response.body)
      expect(response.status).to eql 422
      expect(parsed_response).to eql expected_response
    end
  end

  context 'destroy' do
    it 'updates token' do
      key = FactoryGirl.create :auth_key, token: 'token123'
      delete :destroy, id: key.token
      key.reload
      expect(response.status).to eql 200
      expect(key.token).to_not eql 'token123'
    end

    it 'returns proper errors' do
      delete :destroy, id: 'token1234'
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response).to have_key(:errors)
      expect(response.status).to eql 401
    end
  end
end
