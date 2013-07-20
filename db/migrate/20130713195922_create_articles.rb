class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :name
      t.string :content
      t.belongs_to :game


      t.timestamps
    end
  end
end
