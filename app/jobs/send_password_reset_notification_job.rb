class SendPasswordResetNotificationJob < ApplicationJob
  sidekiq_options queue: :mailers
  sidekiq_throttle_as :mailer

  def perform(user_id, reset_token)
    user = User.find(user_id)
    return if user.blank? || reset_token.nil?

    UserMailer.with({ user: user, reset_token: reset_token }).password_reset.deliver_now
  end
end
