class CreateJoinTableUserAvailability < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :availabilities do |t|
      t.index :user_id
      t.index :availability_id
    end
  end
end
