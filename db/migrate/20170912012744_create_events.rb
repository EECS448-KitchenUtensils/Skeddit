class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :start
      t.datetime :end
      t.integer :owner_id
      t.timestamps
    end
  end
end
