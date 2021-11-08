require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test 'task created' do
    user = create(:user)
    task = create(:task, author: user)
    params = { user: user, task: task }
    email = UserMailer.with(params).task_created

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['noreply@taskmanager.com'], email.from
    assert_equal [user.email], email.to
    assert_equal 'New Task Created', email.subject
    assert email.body.to_s.include?("Task #{task.id} was created")
  end

  test 'password reset' do
    user = create(:user)
    reset_token = user.new_token
    params = { user: user, reset_token: reset_token }
    email = UserMailer.with(params).password_reset

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal 'Password Reset', email.subject
    assert_equal [user.email], email.to
    assert_equal ['noreply@taskmanager.com'], email.from
    assert_match reset_token, email.body.encoded
    assert_match CGI::escape(user.email), email.body.encoded
  end
end
