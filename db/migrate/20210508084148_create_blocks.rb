class CreateBlocks < ActiveRecord::Migration[6.0]
  def change
    create_table :blocks do |t|
      t.integer :block_id
      t.integer :blocked_id

      t.timestamps
    end
    add_index :blocks, :block_id
    add_index :blocks, [:block_id, :blocked_id], unique: true
  end
end
