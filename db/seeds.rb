# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Book.destroy_all
Stat.destroy_all

Stat.create(name: "freq_loc")
Stat.create(name: "avail_book_count", content: {"avail_book_count"=>"0"})

10.times do |u|
  User.create! firstname: "Foo#{u}", lastname: "Bar#{u}", email: "test#{u}@testaccountasdfqwer.com", password: "testtest"
end

seed_title = ["Fiction", "Critics", "Science", "History", "Romance"]

seed_author = ["Asonnate", "Beatrice", "Collins", "DaVince", "Edger", "Friedgershaw", "Gamovs"]


seed_loc = ["Central", "Wan Chai", "Chai Wan", "Ap Lei Chau", "Kowloon City", "Wong Tai Sin", "Kwun Tong", 
             "Yau Ma Tei", "Tsim Sha Tsui", "Mong Kok", "Sham Shui Po", "Tsuen Wan", "Kwai Chung",
             "Sai Kung", "Sha Tin", "Tai Po", "Tuen Mun", "Yuen Long", "Lantau Island"]

seed_isbn = ["1a", "2b", "3c", "4d", "5e"]

seed_tags = ["Highly Recommended", "Worth Reading", "Loved to share"]


seed_image_location = "app/assets/images/development/Seed images/"
exclude_list = [".", "..", ".DS_Store"]
seed_image_filelist = Dir.entries(seed_image_location) - exclude_list


10.times do |b|
  user = User.all.sample
  f = File.open(seed_image_location+seed_image_filelist.sample)
  user.books.create!(
  	title: seed_title.sample, 
  	author: seed_author.sample, 
  	availability: [true, false].sample,
  	country: "Hong Kong", 
    loc: seed_loc.sample,
    isbn: seed_isbn.sample,
  	tags: seed_tags.sample,
  	image: f
  	)
  f.close
end