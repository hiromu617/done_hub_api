class CreateDonePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :done_posts do |t|
      t.text :title
      t.text :comment
      t.integer :user_id

      t.timestamps
    end
  end
end
