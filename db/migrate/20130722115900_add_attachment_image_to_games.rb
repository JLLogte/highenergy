class AddAttachmentImageToGames < ActiveRecord::Migration
  def self.up
    change_table :games do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :games, :image
  end
end
