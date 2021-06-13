class AddColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :college, :string, :default => ""
    add_column :users, :faculty, :string, :default => ""
    add_column :users, :department, :string, :default => ""
  end
end
