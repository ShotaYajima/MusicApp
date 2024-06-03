class AddArtistTitleAndImageUrlToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :artist_title, :string
    add_column :posts, :image_url, :string
  end
end
