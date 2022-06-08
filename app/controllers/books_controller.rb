class BooksController < ApplicationController
  before_action :find_book, only: [:show, :edit, :update, :destroy]
  def index
    if params[:category].blank?
      @books = Book.all.order("created_at DESC")
    else
      @category_id = Category.find_by(name: params[:category]).id
      @books = Book.where(:category_id => @category_id).order("created_at DESC")
    end
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
# modify4
  def create
   # byebug
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
  
    # @book.category_id = params[:category_id]
    # if @categories.nil?
    #   flash[:alert] = "enter valid details"
    # else
    @categories = Category.all || []
    @categories = Category.all.map{ |c| [c.name, c.id] }

    #end
  end

  def update
    #byebug
    @book.category_id = params[:category_id]
    if @book.update(book_params)
      flash[:success] =  "Book details updated!"
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    flash[:success] = "Book deleted successfully!"
    redirect_to root_path
  end
  private
      def book_params

        #params.require(:book).permit(:title, :description, :author, :category_id, :book_img)
        #params.require(:book).permit(:title, :description, :author, :category_id)
        params.fetch(:book, {}).permit(:title, :description, :author, :category_id, :book_img, :user_id)

      end
      def find_book
        @book = Book.find(params[:id])
      end

end
