class CreateReplies < ActiveRecord::Migration[6.0]
  def change
    create_table :replies do |t|
      t.references :user, null: false, foreign_key: true
      t.references :done_post, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
