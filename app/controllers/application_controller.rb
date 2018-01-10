class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  def talk_content id
  	@user = User.find(id)
  	@comment = Comment.all
    Comment.talking_user(@user,current_user)
    #talking_userメソッドはcomment.rbに記載
  end
end