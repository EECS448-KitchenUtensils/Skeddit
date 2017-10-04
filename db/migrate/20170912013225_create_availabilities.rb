class CreateAvailabilities < ActiveRecord::Migration[5.1]
  def change
    create_table :availabilities do |t|
      t.integer :event_id
      t.integer :user_id
      t.datetime :start
      t.timestamps
    end
  end
end
