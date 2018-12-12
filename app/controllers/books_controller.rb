class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :want, :match]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :want, :match]
  before_action :set_meta_title
  # GET /books
  # GET /books.json
  def index
    @books = Book.search_books(params).paginate(page: params[:books_page], per_page: 8)
    respond_to do |format|
      format.html
    end    
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @wanteds = @book.wanteds.paginate(page: params[:wanteds_page], per_page: 8)
    params[:wanteds_page] ||= 1
    respond_to do |format|
      format.js
    end
  end

  # GET /books/new
  def new
    @book = current_user.books.new
  end

  # GET /books/1/edit
  def edit
    redirect_to @books_path, notice: "Not authorised to perform this action." if !check_id
  end

  # POST /books
  # POST /books.json
  def create
    @book = current_user.books.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to shelf_path, notice: 'Book created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to shelf_path, notice: 'Book updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    if !check_id
      redirect_to books_path, notice: "Not authorised to perform this action."
    else
      @book.destroy
      respond_to do |format|
        format.html { redirect_to shelf_path, notice: 'Book removed.' }
        format.json { head :no_content }
      end
    end
  end

  def want
    Wanted.create(book_params)
    respond_to do |format|
      format.js
    end
    UserMailer.wanted_notification(current_user, @book, book_params[:wantreason].to_s).deliver_later!
  end

  def match
    @wanter = User.find(params[:wanter])
    if !(@book.matched.users.include?(@wanter))
      @book.matched.users << @wanter
      redirect_to book_path(wanteds_page: params[:wanteds_page]), turbolinks: false
      UserMailer.matched_notification(@wanter, @book).deliver_later!
    end
      
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    def set_meta_title
      @meta_title = meta_title('Books')
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :author, :availability, :country, :loc, :isbn, :image, :tags, :user_id, :book_id, :wanter, :wantreason, :str_tags)
    end

    def check_id
      @book.user == current_user
    end




end
