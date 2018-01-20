class UserMailer < ApplicationMailer
  def order_customer (user, items)
  	@user = user
  	@items = items
  	mail to: user.email, subject: 'お買い上げありがとうございます\n下記の銀行口座にお振込みください'
  end
end
