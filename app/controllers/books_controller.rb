#Api::V1::
class BooksController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]

    def index
        if params[:name]
            @books = Book.where('name LIKE ?', "%#{params[:name]}%")
        elsif params[:author]
            @books = []
            @authors = User.where('surname LIKE ?', "%#{params[:author]}%")
            @authors.each do |author|
                books_author = author.books
                books_author.each do |book|
                    @books.push(book)
                end
            end
        else
            @books = Book.all
        end
    end

    def show
        set_book
        @check = List.where(
                user_id: current_user.id, 
                book_id: @book.id
            ).count
    end

    def new
        if current_user.role == 'Writer'
            @book = current_user.books.build
        else
            redirect_to root_path
        end
    end

    def destroy
        set_book
        if set_book.user_id != current_user.id
            redirect_to root_path
        elsif @book.destroy
            redirect_to '/'
        end
    end

    def edit
        set_book
        if set_book.user_id != current_user.id
            redirect_to root_path
        end
    end

    def update
        set_book
        if @book.update(book_params)
            redirect_to root_path
        else
            render 'edit'
        end
    end

    def create
        @book = current_user.books.build(book_params)
        if @book.save
            redirect_to '/'
        else
            render 'new'
        end
    end

    def check_in_list
        return "hello"
    end

    private

    def set_book
        @book = Book.find(params[:id])
    end

    def book_params
        params.require(:book).permit(:name, :description)
    end
end
