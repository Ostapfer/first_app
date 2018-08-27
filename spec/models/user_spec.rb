require 'rails_helper'

# bundle exec rspec ./spec/models/user_spec.rb

RSpec.describe User, :type => :model do
  it "is not valid without attributes" do
    expect( User.new ).to_not be_valid
  end

  it "is not valid without a role" do
    expect( User.new(name: nil) ).to_not be_valid
  end

  it "is valid with a valid attr" do
    expect( User.new( 
                role: "Writer", 
                email: "test@test", 
                password: "123456",
                name: "dima",
                surname: "molodko" ) ).to be_valid
  end

  it "register with valid data, create book and add book in list" do
    user = User.create!(
                  email: "test@test1", 
                  password: "secret", 
                  name: "Di", 
                  surname: "Mo",
                  role: "Writer"
                )
    book = user.books.create!(
                  name: "hello",
                  description: "description"
                )
    list = user.list.create!(
                  book_id: book.id
                )
    # assert_select "form.login" do
    #   assert_select "input[name=?]", "username"
    #   assert_select "input[name=?]", "password"
    #   assert_select "input[type=?]", "submit"
    # end

    # post "/login", :username => "jdoe", :password => "secret"
    # assert_select ".header .username", :text => "jdoe"
  end
end