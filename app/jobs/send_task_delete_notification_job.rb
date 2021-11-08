class SendTaskDeleteNotificationJob < ApplicationJob
  sidekiq_options queue: :mailers
  sidekiq_throttle_as :mailer

  def perform(task_id, author_id)
    author = User.find(author_id)
    return if author.blank?

    UserMailer.with({ user: author, task: task_id }).task_deleted.deliver_now
  end
end
