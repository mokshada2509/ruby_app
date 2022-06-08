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
   
   
    describe 'GET #show' do
      let!(:category) {create(:category)}
      let!(:book) { create(:book, category: category) }
   
      it 'should success and render to edit page' do
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
      let!(:book){create(:book)}
      #let!(:category) {create(:category)}
      #let!(:book) { create(:book, category: category) }

      it 'create a new book' do
        params = {
          category_id: 2,
          title: 'new book',
          description: 'sam',
          author: 'ad'
            
        }
         
        expect{post '/books', params:{book: params}}.to change(Book, :count).by(1)
        #expect(flash[:notice]).to eq 'Book was successfully created.'
      end
    end

    describe 'PUT #update' do
      let!(:book){create :book}
         
      it 'should update book info' do
        params = {
          category_id: 2,
          title: 'new book',
          description: 'sam',
          author: 'ad'
        }
        
        put '/books/1', params:{ id: book.id, book: params }
        book.reload
        params.keys.each do |key|
          expect(book.attributes[key.to_s]).to eq params[key]
          end
      end
    end
       
      describe 'DELETE #destroy' do
        let!(:book){create(:book) }
       
        it 'should delete book' do
          expect{delete '/books/1', params:{ id: book.id } }.to change(Book, :count).by(-1)
          #expect(flash[:notice]).to eq 'Book deleted successfully!'
        end
      end
end