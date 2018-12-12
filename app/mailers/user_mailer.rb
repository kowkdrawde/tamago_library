class UserMailer < ApplicationMailer
	default from: "tamagolibrary@gmail.com"

	def welcome_email(user)
      @user = user
      attachments.inline["emailheader.jpg"] = File.read("app/assets/images/development/emailheader.jpg")
      mail(to: @user.email, subject: "Welcome to "+ ENV['BRAND'])
	end

  def wanted_notification(wanter, book, wantreason)
    @user = book.user
    @wanter = wanter
    @book = book
    @wantreason = wantreason
    attachments.inline["emailheader.jpg"] = File.read("app/assets/images/development/emailheader.jpg")
    mail(to: @user.email, subject: "Your #{@book.title} got wanted")
  end

  def matched_notification(wanter, book)
    @wanter = wanter
    @owner = book.user
    @book = book
    attachments.inline["emailheader.jpg"] = File.read("app/assets/images/development/emailheader.jpg")
    mail(to: ["#{@wanter.email}", "#{@owner.email}"], subject: "#{@book.title} got matched")
  end
end
