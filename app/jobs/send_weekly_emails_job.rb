class SendWeeklyEmailsJob < ApplicationJob
  queue_as :default

  def perform
    User.find_each do |user|
      begin
        WeeklyEmailMailer.weekly_email(user).deliver_now
        Rails.logger.info "Weekly email sent to #{user.email}"
      rescue => e
        Rails.logger.error "Failed to send weekly email to #{user.email}: #{e.message}"
      end
    end
  end
end
