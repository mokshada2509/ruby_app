class ReviewsController < ApplicationController
  before_action :find_book
  before_action :find_review, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit]
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.book_id = @book.id
    @review.user_id = current_user.id


    if @review.save
      flash[:success] =  "New Review created successfully!"
      redirect_to book_path(@book)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      flash[:success] =  "Review updated!"
      redirect_to book_path(@book)
    else
      render 'edit'
    end
  end

  def destroy
    @review.destroy
    redirect_to book_path(@book)
    flash[:success] = "Review deleted successfully!"
  end

  private
    def review_params
      params.require(:review).permit(:rating, :comment)
    end

    def find_book
      @book = Book.find(params[:book_id])
    end

    def find_review
      @review = Review.find(params[:id])
    end

end
