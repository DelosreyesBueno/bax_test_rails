class TokenService
  @@key = ""

  def self.generate_token
    token = SecureRandom.uuid
    stored_token(token)
    token    
  end

  def self.valid_token?(token)
    stored_token = retrieve_token
    correct_token = stored_token && stored_token[:value] == token && Time.now - stored_token[:created_at] <= 100.seconds
    return { error: ErrorManager.error(:token_not_found)}  if !correct_token

    correct_token
  rescue
    { error: ErrorManager.error(:token_not_found) }
  end
  
  def self.validate_token_time
    Time.now - @@stored_token[:created_at]
  end

  def self.token
    @@stored_token[:value]
  end

  def self.save_key(key)
    @@key = key
  end

  def self.get_key
    @@key
  end

  private

  def self.stored_token(token)
    @@stored_token = { value: token, created_at: Time.now }
  end

  def self.retrieve_token
    @@stored_token
  end
end