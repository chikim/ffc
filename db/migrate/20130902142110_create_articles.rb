class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :type
      t.string :title
      t.string :short_description
      t.text :content

      t.timestamp
    end

    add_attachment :articles, :cover_image
  end
end
