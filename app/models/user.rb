class User < ActiveRecord::Base
  establish_connection :development
  self.table_name = 'user_service_dev'

  def self.find_by(token)
    query = "SELECT * FROM users WHERE auth_token = '#{token}'"
    User.connection.execute(query).first
  end
end
