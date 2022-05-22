class BooksController < ApplicationController
  before_action :find_book, only: [:show, :edit, :update, :destroy]
  def index
    @books = Book.all.order("created_at DESC")
  end
# modify3
  def show
    @book = Book.find(params[:id])
  end
  # modification 
  def new
    @book = current_user.books.build
    @categories = Category.all.map{ |c| [c.name, c.id] }
  end

  def create
    @book = current_user.books.build(book_params)
    @book.category_id = params[:category_id]

    if @book.save
      flash[:success] =  "New book created successfully!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      flash[:success] =  "Book details updated!"
      redirect_to book_path(@book)
    else
      render 'edit'
    end
  end

  def destroy
    @book.destroy
    flash[:success] = "Book deleted successfully!"
    redirect_to root_path
  end
  private
      def book_params
        params.require(:book).permit(:title, :description, :author, :category_id)
      end
      def find_book
        @book = Book.find(params[:id])
      end

end
