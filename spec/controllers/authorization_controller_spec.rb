require 'spec_helper'

describe AuthorizationController, type: :controller do
  context '.check_authorization' do
    it 'renders proper data for authorized' do
      token = '123qwer'
      request.headers['Authorization'] = token
      allow(Authenticable).to receive(:validate_token).with(token).and_return true
      expected_response = { "success" => true}
      post :check_authorization
      expect(response.status).to eql 200
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).to eql expected_response
    end
    it 'renders proper data for unauthorized' do
      token = '123qwer'
      request.headers['Authorization'] = token
      expected_response = { "success" => false}
      post :check_authorization
      expect(response.status).to eql 401
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).to eql expected_response
    end

    it 'invalidates token after 24 hours' do
      User.establish_connection :test
      User.table_name = 'user_service_test'
      User.connection.execute("DELETE FROM users")
      query = "INSERT INTO users (id, email, role, auth_token, token_created_at)
              VALUES ('1', 'email@test.com', 'admin', '1234qwe', '#{(Time.now - 2.days).to_date}')"
      User.connection.execute(query)
      expect(Authenticable.validate_token('1234qwe')).to eql false

    end
  end

end
