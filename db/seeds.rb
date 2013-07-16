# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Setup the roles
r = Role.create(name: "admin")

r = Role.create(name: "user")

u = User.create({ :email => 'ruminatious@gmail.com', 
				  :password => 'password', 
				  :password_confirmation => 'password'})

u.role = Role.admin

g = Game.create(name: "dota2")

g = Game.create(name: "CS:GO")

a = Article.create({ :name => 'Good', 
					 :content => 'Great Content'})

a = Article.create({ :name => 'Bad', 
					 :content => 'Bleh'})

a = Article.create({ :name => 'Ugly', 
					 :content => 'Yeah it is'})

