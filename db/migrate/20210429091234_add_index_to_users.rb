class AddIndexToUsers < ActiveRecord::Migration[6.0]
  def change
    add_index :users, [:id, :uid], unique: true
  end
end
