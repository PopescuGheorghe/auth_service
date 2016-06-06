module Authenticable
  # Public: verifies validation of token
  # token - token of the user
  # returns - boolean
  def self.validate_token(token)
    key = AuthKey.find_by(token: token)
    return false unless key.present?
    key['token_created_at'].to_date + 24.hours > Time.now if key['token_created_at'].present?
  end

  def self.current_user(token)
    key = AuthKey.find_by(token: token)
  end
end
