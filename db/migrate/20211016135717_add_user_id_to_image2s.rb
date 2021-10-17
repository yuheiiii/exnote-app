class AddUserIdToImage2s < ActiveRecord::Migration[5.2]
  def change
    add_column :image2s, :user_id, :string
  end
end
