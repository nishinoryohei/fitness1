class Comment < ApplicationRecord
	validates :content, presence: true
	belongs_to :receiver, class_name: 'User', optional: true
	belongs_to :server, class_name: 'User', optional: true

	scope :talking_user, -> (user,current_user) {
		where('server_id = ? or server_id = ?',user.id,current_user.id)
		.where('receiver_id = ? or receiver_id = ?',user.id,current_user.id)
	}
end