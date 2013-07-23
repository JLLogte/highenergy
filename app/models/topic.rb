class Topic < ActiveRecord::Base
  validates :name, presence: true

  has_many :subscriptions
  has_many :users, through: :subscriptions

  has_many :articles

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

  def get_image
    return nil if self.image.url == "/images/original/missing.png"

    return self.image.url
  end
  
end
