class UsersController < ApplicationController
    
    def index
        @users = User.order(username: :asc)
    end

    def show
    end

    def edit
    end

    def update
        @user = User.find(current_user.id)
        if @user.update_with_password user_params
        bypass_sign_in @user
          redirect_to users_path, notice: 'Password successfully changed!'
        else
          redirect_to edit_user_path, alert: 'Password updating failed!'
        end
    end

    def destroy
        redirect_to users_path if @user.destroy
    end
    
    private
    
    def user_params
        params.require(:user).permit(:password, :password_confirmation,
                                     :current_password)
    end
end
