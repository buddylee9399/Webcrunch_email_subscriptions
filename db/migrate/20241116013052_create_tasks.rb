class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.text :body
      t.references :project, null: false, foreign_key: true
      t.boolean :complete, default: false

      t.timestamps
    end
  end
end
