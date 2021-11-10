class SendTaskDeleteNotificationJob < ApplicationJob
  sidekiq_options queue: :mailers
  sidekiq_options lock: :until_and_while_executing, on_conflict: { client: :log, server: :reject }
  sidekiq_throttle_as :mailer

  def perform(task_id, author_id)
    author = User.find(author_id)
    return if author.blank?

    UserMailer.with({ user: author, task: task_id }).task_deleted.deliver_now
  end
end
