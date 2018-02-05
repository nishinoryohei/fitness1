class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :personal
  has_many :bodies
  has_many :trainings
  has_many :items
  has_many :cart_items
  has_many :reviews
  has_many :orders
  has_many :server, foreign_key: 'server_id', 
            class_name: 'Comment', dependent: :destroy
  has_many :receiver, foreign_key: 'receiver_id',
            class_name: 'Comment', dependent: :destroy
  validates :email, presence: true
  validates :name, presence: true, uniqueness: true
  def self.trainers
  	select{|f| f.trainer == true }
  end
  def self.customers
    select{|f| f.trainer == false }
  end
  def self.during_a_call user
    d = user.receiver.map(&:server_id) + user.server.map(&:receiver_id)
    find(d.uniq)
  end
end

