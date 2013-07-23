class AddAttachmentImageToTopics < ActiveRecord::Migration
  def self.up
    change_table :topics do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :topics, :image
  end
end
