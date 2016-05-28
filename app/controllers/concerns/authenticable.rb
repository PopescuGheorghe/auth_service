module Authenticable
  # Public: verifies validation of token
  # token - token of the user
  # returns - boolean
  def self.validate_token(token)
    user = User.find_by(token)
    return false unless user.present?
    user['token_created_at'].to_date + 24.hours > Time.now if user['token_created_at'].present?
  end
end
