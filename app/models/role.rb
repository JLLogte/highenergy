class Role < ActiveRecord::Base
	has_many :user_roles
	has_many :users, through: :user_roles

	def self.admin
		Role.where(name: "admin").first
	end

	def self.user
		Role.where(name: "user").first
	end
end
