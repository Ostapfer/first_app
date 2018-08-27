require "rails_helper"

# bundle exec rspec ./spec/controllers/books_spec.rb

RSpec.describe BooksController do
  describe "GET index" do
    it "assigns @book" do
      book = Book.create
      get :index
      expect(assigns(:books)).to eq([book])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
end