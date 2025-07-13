class WeeklyEmailMailer < ApplicationMailer
  def weekly_email(user)
    @user = user
    @greeting = "Good Shabbos, #{user.first_name}!"
    
    mail(
      to: user.email,
      subject: "Your Weekly Shabbos PDF is Ready!"
    )
  end
end
