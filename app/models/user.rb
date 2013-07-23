class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  has_one :user_role
  has_one :role, through: :user_role

  has_many :subscriptions
  has_many :topics, through: :subscriptions

  has_many :articles, through: :topics
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def is_admin?
  	return false if not (self.role || Role.admin)

  	return self.role == Role.admin
  end

  def is_subscribed?(topic)
    return self.topics.include?(topic)
  end

  def get_articles
    return self.articles.order("created_at DESC").limit(10)
  end
end
