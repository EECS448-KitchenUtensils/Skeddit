class CreateAvailabilities < ActiveRecord::Migration[5.1]
  def change
    create_table :availabilities do |t|
      t.integer :event_id
      t.integer :user_id
      t.daterange :duration
      t.timestamps
    end
  end
end
