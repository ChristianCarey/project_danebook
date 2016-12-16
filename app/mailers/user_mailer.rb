class UserMailer < ApplicationMailer
  default from: "vikings@danebook.dk"
  
  def welcome(user)
    @user = user 
    mail(to: user.email, subject: "One of us!")
  end
end
