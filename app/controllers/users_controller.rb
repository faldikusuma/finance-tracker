class UsersController < ApplicationController
  def my_portfolio
    @user = current_user
    @tracker_stock = current_user.stocks
  end
  
  def my_friends
    @friends = current_user.friends
  end
  def show
    @user = User.find(params[:id])
    @tracker_stock = @user.stocks  
  end
  def search
    if params[:friend].present?
     
      @friends = User.search(params[:friend])
      @friends = current_user.except_current_user(@friends)
     
      if @friends
        respond_to do |format|
          format.js {render partial: 'users/friend_result'}
        end
      else
        respond_to do |format|
          flash.now[:alert] = "users not found"
          format.js {render partial: 'users/friend_result'}
        end
      end    
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter user name"
        format.js {render partial: 'users/friend_result'}
      end
    end
  end
end
