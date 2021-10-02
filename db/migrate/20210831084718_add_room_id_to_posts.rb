class AddRoomIdToPosts < ActiveRecord::Migration[5.2]
  def change

  add_column :posts, :room_id, :string

  end
end
