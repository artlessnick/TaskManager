module PasswordResetable
  def generate_reset_digest
    reset_token = new_token
    update(reset_digest: digest(reset_token), reset_sent_at: Time.zone.now)
    reset_token
  end

  def authenticated?(token)
    return if reset_digest.nil? || reset_sent_at < 24.hours.ago

    BCrypt::Password.new(reset_digest).is_password?(token)
  end

  def new_token
    SecureRandom.urlsafe_base64
  end

  def digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
