class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :game
      t.integer :user

      t.timestamps
    end
  end
end
