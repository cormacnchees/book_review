class BooksController < ApplicationController
  #before actions (DRY code). We want to find put for show, edit, updat, and destory. Makes @book accessable in each def
  before_action :find_book, only: [:show, :edit, :update, :destroy]
  #prevent non-logged in users from accessing certain pages (redirects to sign-in)
  before_action :authenticate_user!, only: [:new, :edit]

  def index
    #If Statement to sort books by category in index view
    if params[:category].blank?
      #display books in decending order by time
      @books = Book.all.order("created_at DESC")
    else
      @category_id = Category.find_by(name: params[:category]).id
      @books = Book.where(:category_id => @category_id).order('created_at DESC')
    end
  end

  def show
    if @book.reviews.blank?
      @average_review = 0
    else
      @average_review = @book.reviews.average(:rating).round(2)
    end
  end

  #create new Book
  def new
    #instance variable
    @book = current_user.books.build
    @categories = Category.all.map{ |c| [c.name, c.id] }
  end

  def create
    @book = current_user.books.build(book_params)
    #when submitting form, it will associate book with a category id
    @book.category_id = params[:category_id]

    #when book is created (submit btn), go to home page
    if @book.save
      redirect_to root_path
    else
      #render new form
      render 'new'
    end
  end

  def edit
    @categories = Category.all.map{ |c| [c.name, c.id] }
  end

  def update
    @book.category_id = params[:category_id]
    #redirects to book showpage with new book_params after update
    if @book.update(book_params)
      redirect_to book_path(@book)
    else
      render 'edit'
    end
  end

  def destroy
    @book.destroy
    #redirect to showpage once book is removed
    redirect_to root_path
  end


  private

    #information user fills out in form
    def book_params
      params.require(:book).permit(:title, :description, :author, :category_id, :book_img   )
    end

    def find_book
      #find book by id and assign as instance variable (@book)
      @book = Book.find(params[:id])
    end
end
