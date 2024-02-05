class AuctionsMailer < ApplicationMailer
  def winner_email(user, auction)
    @user = user
    @auction = auction
    mail(to: @user.email, subject: 'Congratulations! You won the auction')
  end

  def losers_email(users, auction)
    @users = users
    @auction = auction
    loser_emails = @users.map(&:email)
    mail(to: loser_emails, subject: 'Better luck next time!')
  end
  
end
