class AddColumnDonePost < ActiveRecord::Migration[6.0]
  def change
    add_column :done_posts, :tasks, :json, array: true
  end
end
