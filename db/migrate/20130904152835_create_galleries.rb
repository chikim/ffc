class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :title
      t.integer :cover_photo_id

      t.timestamps
    end
  end
end
