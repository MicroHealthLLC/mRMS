class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.string :name
      t.integer :category_id
      t.integer :category_type_id
      t.integer :user_id
      t.string :document

      t.timestamps
    end
    add_index :reports, :category_id
    add_index :reports, :category_type_id
    add_index :reports, :user_id
  end

  EnabledModule.create(name: 'reports')
end
