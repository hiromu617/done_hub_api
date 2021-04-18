class DeleteAvatarColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :avatar, :string
  end
end
