class User < ApplicationRecord
  has_secure_password
  validates :username, uniqueness: true, presence: true
  validates :password, length: { minimum: 6 },  :on => :create
  belongs_to :team, optional: true
  has_many :created_games, class_name: 'Game', :foreign_key => 'creator_id'

end
