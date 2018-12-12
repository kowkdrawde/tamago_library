# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

	def welcome_email
      UserMailer.welcome_email(User.all.sample)
	end

    def wanted_notification(wanter, book, wantreason)
      @user = book.user
      @wanter = wanter
      @book = book
      @wantreason = wantreason
      mail(to: @user.email, subject: "Your #{@book.title} got wanted")
    end

    def matched_notification(wanter, book)
      @wanter = wanter
      @owner = book.user
      @book = book
      mail(to: ["#{@wanter.email}", "#{@owner.email}"], subject: "#{@book.title} got matched")
    end


end
