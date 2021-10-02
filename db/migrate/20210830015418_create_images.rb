class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :room_number
      t.string :image_name

      t.timestamps
    end
  end
end
