class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :room_id
      t.string :password_digest

      t.timestamps
    end
  end
end
