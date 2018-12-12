class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:dashboard, :wanted]

  def index
  	@books = Book.all.first(4)
    @rand = Book.pluck(:loc, :country).uniq.map {|loc, country| loc+", "+country}.sample(3)
    @count = Stat.get_avail_book_count
  end
  
  def my_wanted_books
    book_ids = current_user.wanteds.pluck(:book_id)
    @books = Book.where(id: book_ids).paginate(page: params[:books_page], per_page: 8)
    @meta_title = meta_title('My Wanted')
  end

  def my_shelf
    @books = current_user.books.paginate(page: params[:books_page], per_page: 8)
    @meta_title = meta_title('My Shelf')
  end


  def about
    @meta_title = meta_title('About')
  end
end
