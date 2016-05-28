class AuthKey < ActiveRecord::Base
  validates :token, uniqueness: true, presence: true
  validates :token_created_at, presence: true
  # Public: generates an authentication token
  # returns - token for the user
  def self.generate_authentication_token
    Digest::SHA1.hexdigest([Time.now, rand].join)
  end

  # Public: models JSON representation of the object
  # _options - parameter that is provided by the standard method
  # returns - hash with token
  def as_json(_options = {})
    {
      token: token
    }
  end
end
