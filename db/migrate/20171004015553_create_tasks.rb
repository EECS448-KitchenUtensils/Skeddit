class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.text :name
      t.belongs_to :event, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
