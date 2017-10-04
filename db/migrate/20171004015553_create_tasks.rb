class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.text :name
      t.integer :event_id
      t.integer :participant_id
    end
  end
end
