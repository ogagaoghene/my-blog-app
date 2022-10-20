class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foriegn_key: true, index:true
      t.string :title
      t.text :text
      t.integer :comments_counter
      t.integer :likes_counter
      
      t.timestamps
    end
  end
end
