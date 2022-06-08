require 'rails_helper'

RSpec.describe "Book", :type => :request do
  describe '#create' do
    it "creates a book and redirects to the book's page" do
      render 'new'
      #expect(response).to render_template(:new)

### This is where the error is happening. On the `post` method.
      #post "/posts", :post => {:title => "My Post", :content => "My post content"}

      #expect(response).to redirect_to(assigns(:post))
      #follow_redirect!

      #expect(response).to render_template(:show)
      #expect(response.body).to include("Post was successfully created.")
    end

    #it "does not render a different template" do
     # get "/posts/new"
     # expect(response).to_not render_template(:show)
    #end
  end
end