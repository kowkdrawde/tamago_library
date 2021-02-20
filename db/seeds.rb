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
Booktag.destroy_all

Stat.create(name: "freq_loc")
Stat.create(name: "avail_book_count", content: {"avail_book_count"=>"0"})


seed_title = []
seed_author = []
seed_isbn = []

10.times do |u|
  User.create! firstname: "Foo#{u}", lastname: "Bar#{u}", email: "test#{u}@testaccountasdfqwer.com", password: "testtest"
  seed_title.append('Title '+u.to_s)
  seed_author.append('Author '+u.to_s)
  seed_isbn.append('isbn no.'+u.to_s)
end

seed_loc = ["London", "Manchester", "Birmingham", "Leeds", "Glasgow", "Southhampton", "Liverpool", 
             "Newcastle", "Sheffield"]

seed_tags = ["Brandnew", "WorthReading", "OnlyforInterested", "NotforSale", "SelfPick"]


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
  	country: "United Kingdom", 
    loc: seed_loc.sample,
    isbn: seed_isbn.sample,
  	image: f
  	)
  2.times {|bt| user.books.sample.booktags.find_or_create_by(name: seed_tags.sample.downcase)}
  f.close
end