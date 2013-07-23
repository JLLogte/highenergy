class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :name
      t.string :content
      t.string :source_url
      t.belongs_to :topic


      t.timestamps
    end
  end
end
