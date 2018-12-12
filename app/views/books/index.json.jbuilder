json.array!(@books) do |book|
  json.extract! book, :id, :title, :author, :availability, :category, :avg_rating, :user_id
  json.url book_url(book, format: :json)
end
