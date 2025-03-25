class UserMailer < ApplicationMailer
  default from: 'panuking390@gmail.com'

  def approval_email(user)
    @user = user
    mail(to: @user.email, subject: 'Eone - Your Account Has Been Approved')
  end

  def rejection_email(user)
    @user = user
    mail(to: @user.email, subject: 'Eone - Your Account Has Been Rejected')
  end
end
