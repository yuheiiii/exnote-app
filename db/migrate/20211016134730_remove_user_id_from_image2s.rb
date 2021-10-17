class RemoveUserIdFromImage2s < ActiveRecord::Migration[5.2]
  def change
    remove_column :image2s, :user_id, :string
    remove_column :image2s, :post_id, :string
  end
end
