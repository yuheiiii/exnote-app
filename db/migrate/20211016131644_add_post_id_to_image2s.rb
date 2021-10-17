class AddPostIdToImage2s < ActiveRecord::Migration[5.2]
  def change
    add_column :image2s, :post_id, :string
  end
end
