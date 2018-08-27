class ListsController < ApplicationController
    before_action :authenticate_user!

    def index
        @lists = List.all.where(user_id: current_user.id)
    end

    def update
        set_list
        if @list.update(list_params_read)
            redirect_to lists_path
        else
            redirect_to root_path
        end
    end

    def destroy
        set_list
        if @list.user_id != current_user.id
            redirect_to root_path
        elsif @list.destroy
            redirect_to lists_path
        end
    end

    def create
        @check = List.where(
                user_id: list_params[:user_id], 
                book_id: list_params[:book_id]
            ).count
        
        if @check == 0
            @list = List.new(list_params)
            if @list.save
                redirect_to lists_path
            else
                redirect_to root_path
            end
        else
            redirect_to lists_path
        end
    end

    private
    def set_list
        @list = List.find(params[:id])
    end

    def list_params
        params.require(:list).permit(:user_id, :book_id)
    end

    def list_params_read
        params.require(:list).permit(:read)
    end
end
