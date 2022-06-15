require 'rails_helper'

RSpec.describe Review, type: :request do
  let(:user){create(:user)}
  # describe "GET /index" do
  #   #pending "add some examples (or delete) #{__FILE__}"
  # end

  describe 'GET #new' do 
    let!(:category) {create(:category)}
    let!(:book) { create(:book, category: category) }
    let!(:review){create(:review, book: book)}
    it 'should success and render to new page' do
      execute_with_resource_sign_in(user) do
        get '/books/1/reviews/new'
        expect(response).to have_http_status(200)
        expect(response).to render_template :new
      end
    end
  end

  describe 'POST #create' do
    #let!(:book){create(:book)}
    let!(:category) {create(:category)}
    let!(:book) { create(:book, category: category) }
    let!(:review){create(:review, book: book)}
    it 'should create a new review' do
      execute_with_resource_sign_in(user) do
        post '/books/1/reviews',{review:
         {
          rating: 5,
          comment: "very nice",
          user_id: user.id,
          book_id: 1
         }
        }
        is_expected.to redirect_to book_path(book.id)
        expect(flash[:success]).to eq('New Review created successfully!')
      end
    end

    context 'when parameters are not filled' do
      it 'should render new template' do
        execute_with_resource_sign_in(user) do
          post '/books/1/reviews',{review:
           {
            rating: 5,
            comment: "",
            user_id: user.id,
            book_id: 1
            }
          }
          is_expected.to render_template(:new)
          
        end
      end
    end
  end

  describe 'GET #edit' do 
    let!(:category) {create(:category)}
    let!(:book) { create(:book, category: category) }
    let!(:review){create(:review, book: book)}

    it 'should success and render to edit page' do
      execute_with_resource_sign_in(user) do
        get '/books/1/reviews/1/edit'
        expect(response).to have_http_status(200)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'PUT #update' do
    let!(:category) {create(:category)}
    let!(:book) { create(:book, category: category) }
    let!(:review){create(:review, book: book)}

    it 'should update review info' do
      execute_with_resource_sign_in(user) do
        put '/books/1/reviews/1',{review:
          {
            rating: 5,
            comment: "very nice",
            user_id: user.id,
            book_id: 1
          }
        }
        expect(flash[:success]).to eq('Review updated!')
        is_expected.to redirect_to book_path(book.id)
      end
    end

    context 'when parameters are not filled' do
      it 'should render edit template' do
        execute_with_resource_sign_in(user) do
          put '/books/1/reviews/1',{review:
           {
            rating: 5,
            comment: "",
            user_id: user.id,
            book_id: 1
            }
          }
          is_expected.to render_template(:edit)
          
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:book){create(:book) }
    let!(:review){create(:review, book: book)}
    it 'should delete review' do
      execute_with_resource_sign_in(user) do
        expect{delete '/books/1/reviews/1', params:{ id: review.id } }.to change(Review, :count).by(-1)
        expect(flash[:success]).to eq 'Review deleted successfully!'
      end
    end
  end
end
