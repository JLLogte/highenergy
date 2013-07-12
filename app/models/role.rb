class Role < ActiveRecord::Base
	has_and_belongs_to_many :user

	def self.admin
		Role.where(name: "admin").first
	end

	def self.user
		Role.where(name: "user").first
	end
end
