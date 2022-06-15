require 'rails_helper'

RSpec.describe Book, type: :request do
  #describe 'books controller request specs' do
  let(:user){create(:user)}

  describe 'GET #index' do 
    it 'should success and render to index page' do
      execute_with_resource_sign_in(user) do
        get '/books'
        expect(response).to have_http_status(200)
        expect(response).to render_template :index
      end
    end
  end
   
  describe 'GET #new' do 
    it 'should success and render to new page' do
      execute_with_resource_sign_in(user) do
        get '/books/new'
        expect(response).to have_http_status(200)
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #edit' do 
    let!(:category) {create(:category)}
    let!(:book) { create(:book, category: category) }

    it 'should success and render to edit page' do
      execute_with_resource_sign_in(user) do
        get '/books/1/edit'
        expect(response).to have_http_status(200)
        expect(response).to render_template :edit
      end
    end
  end
  
  describe 'GET #show' do
    let!(:category) {create(:category)}
    let!(:book) { create(:book, category: category) }
   
    it 'should success and render to show page' do
      execute_with_resource_sign_in(user) do
        get '/books/1', {
          book:{
          title: "new",
          description: "sam",
          author: "ad"
          }
        }
        expect(response).to have_http_status(200)
        expect(response).to render_template :show
      end
    end
  end 

  describe 'POST #create' do
    #let!(:book){create(:book)}
    let!(:category) {create(:category)}
    let!(:book) { create(:book, category: category) }

    it 'should create a new book' do
      execute_with_resource_sign_in(user) do
        post '/books',{book:
         {
          title: 'new book',
          description: 'sam',
          author: 'ad',
          user_id: user.id,
          category_id: 2
         }
        }
        is_expected.to redirect_to root_path
        #:title, :description, :author, :category_id, :book_img, :user_id)
         
        #expect{post '/books', params:{book: params}}.to change(Book, :count).by(1)
        expect(flash[:success]).to eq('New book created successfully!')
      end
    end

    context 'when parameters are not filled' do
      it 'should render new template' do
        execute_with_resource_sign_in(user) do
          post '/books',{book:
           {
            title: '',
            description: 'sam',
            author: 'ad',
            user_id: user.id,
            category_id: 2
            }
          }
          is_expected.to render_template(:new)
          #:title, :description, :author, :category_id, :book_img, :user_id)
          
          #expect{post '/books', params:{book: params}}.to change(Book, :count).by(1)
          #expect(flash[:success]).to eq('New book created successfully!')
        end
      end
    end
  end

  describe 'PUT #update' do
    let!(:category) {create(:category)}
    let!(:book) { create(:book, category: category) }

    it 'should update book info' do
      execute_with_resource_sign_in(user) do
        put '/books/1',{book:
          {
            title: 'new book',
            description: 'sam',
            author: 'ad',
            user_id: user.id,
            category_id: 2
          }
        }
        expect(flash[:success]).to eq('Book details updated!')
        is_expected.to redirect_to book_path(book.id)
        #put '/books/1', params:{ id: book.id, book: params }
        # book.reload
        # params.keys.each do |key|
        #   expect(book.attributes[key.to_s]).to eq params[key]
        # end
      end
    end

    context 'when parameters are not filled' do
      it 'should render edit' do
        execute_with_resource_sign_in(user) do
          post '/books',{book:
            {
              title: '',
              description: 'sam',
              author: 'ad',
              user_id: user.id,
              category_id: 2
            }
          }
          is_expected.to render_template("books/_form")
          #:title, :description, :author, :category_id, :book_img, :user_id)
          
          #expect{post '/books', params:{book: params}}.to change(Book, :count).by(1)
          #expect(flash[:success]).to eq('New book created successfully!')
        end
      end
    end
  end
       
  describe 'DELETE #destroy' do
    let!(:book){create(:book) }
    it 'should delete book' do
      execute_with_resource_sign_in(user) do
        expect{delete '/books/1', params:{ id: book.id } }.to change(Book, :count).by(-1)
        #expect(flash[:notice]).to eq 'Book deleted successfully!'
      end
    end
  end
end


