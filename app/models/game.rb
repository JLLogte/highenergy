class Game < ActiveRecord::Base
	validates :name, presence: true

	has_many :subscriptions
	has_many :users, through: :subscriptions

	has_many :articles
end
