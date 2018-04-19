class CreateSavePivotTables < ActiveRecord::Migration[5.0]
  def change
    create_table :save_pivot_tables do |t|
      t.integer :report_id
      t.integer :user_id
      t.text :content
      t.string :name

      t.timestamps
    end
    add_index :save_pivot_tables, :report_id
    add_index :save_pivot_tables, :user_id
  end
end
