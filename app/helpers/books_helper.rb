module BooksHelper
  def bookowner(book)
  	return book.user == current_user
  end

  def has_want(book)
    return current_user.wanteds.pluck(:book_id).include? book.id
  end

  def has_matched_user(book, user)
  	return book.matched.users.include? user	
  end

end
