class ChangeDataTitleToUser < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :uid, :decimal
  end
end
