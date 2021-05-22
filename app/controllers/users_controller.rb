class UsersController < ApplicationController

  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @friends = current_user.friends
  end

  def search
    if params[:friend].present?
      @friends = User.search(params[:friend])
      @friends = current_user.except_current_user(@friends)
      if @friends
        respond_to do |format|
          format.js { render partial: 'users/result_friends' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Couldn't find user"
          format.js { render partial: 'users/result_friends' }
        end
      end    
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a friend username or email to search"
        format.js { render partial: 'users/result_friends' }
      end
    end  
  end
end
