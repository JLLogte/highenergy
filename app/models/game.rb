class Game < ActiveRecord::Base
	validates :name, presence: true

	has_many :subscriptions
	has_many :users, through: :subscriptions

	has_many :articles

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png" 
end
