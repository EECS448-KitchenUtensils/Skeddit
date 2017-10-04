class CreateAvailabilities < ActiveRecord::Migration[5.1]
  def change
    create_table :availabilities do |t|
      t.integer :event_id
      t.integer :user_id
      t.time :start_time
      t.time :end_time
      t.date :start_date
      t.date :end_date
      t.timestamps
    end
  end
end
