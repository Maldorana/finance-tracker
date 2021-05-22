class FriendshipsController < ApplicationController

    def create
        friend = User.find(params[:friend])
        current_user.friendships.build(friend_id: friend.id)
        if current_user.save
            flash[:notice] = "You are now following #{friend.username}"
        else  
        flash[:notice] = "There was something wrong with the tracking request"
      end
      redirect_to my_friends_path
    end

    def destroy
        friendship = current_user.friendships.where(friend_id: params[:id]).first
        friendship.destroy
        flash[:notice] = "You are not following this user anymore"
        redirect_to my_friends_path
    end

end
