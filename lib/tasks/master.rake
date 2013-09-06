require "csv"

def create_master model_class, &block
  return unless block_given?

  csv = "#{Rails.root}/db/master/#{model_class.name.split('::').last.underscore}.csv"
  model_class.destroy_all
  model_class.create! CSV.open(csv).map(&block)
end

namespace :master do
  desc "import master"
  task import: :environment do
    Article.destroy_all
    puts "Create Article"
    create_master Article do |article|
      {id: article[0], type: article[1], title: article[2], short_description: article[3], content: article[4]}
    end

    Trainer.destroy_all
    puts "Create Trainer"
    create_master Trainer do |trainer|
      {id: trainer[0], name: trainer[1], position: trainer[2], self_introduction: trainer[3], bio: trainer[4]}
    end

    Gallery.destroy_all
    puts "Create Gallery"
    create_master Gallery do |gallery|
      {id: gallery[0], title: gallery[1], cover_photo_id: gallery[2]}
    end

    Photo.destroy_all
    puts "Create Photo"
    create_master Photo do |photo|
      {id: photo[0], title: photo[1], gallery_id: photo[2]}
    end

    Video.destroy_all
    puts "Create Video"
    create_master Video do |video|
      {id: video[0], title: video[1], url: video[2]}
    end
  end
end
