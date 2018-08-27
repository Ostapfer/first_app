module ApplicationHelper
    def check_book_in_list(book_id)
        @check = List.where(
                user_id: current_user.id, 
                book_id: book_id
            ).count
        return true if @check == 1
        false
    end

    def full_title(page_title)
        return "Page" if page_title.empty?
        return page_title
    end
end
