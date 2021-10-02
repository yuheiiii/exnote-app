class CreateImage2s < ActiveRecord::Migration[5.2]
  def change
    create_table :image2s do |t|
      t.string :room_number
      t.string :image_name
      t.string :user_id

      t.timestamps
    end
  end
end
