class CreateTrainers < ActiveRecord::Migration
  def change
    create_table :trainers do |t|
      t.string :name
      t.string :position
      t.text :self_introduction
      t.text :bio

      t.timestamps
    end

    add_attachment :trainers, :profile_picture
  end
end
