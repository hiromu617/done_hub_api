class CheangeUidToUsers < ActiveRecord::Migration[6.0]
  def up
    change_column :users, :uid, :string, unique: true 
  end

  def down
    change_column :users, :uid, :string
  end
end
