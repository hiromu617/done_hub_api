class AddColumnExpoPushTokenToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :expo_push_token, :string, default: ""
  end
end
