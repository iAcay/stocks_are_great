class FriendshipsController < ApplicationController
  def index
    @friendships = Friendship.where(user_id: current_user.id)
  end

  def destroy
    friendship = Friendship.find(params[:id])
    friendship.destroy
    redirect_to friendships_path, notice: "You are not already tracking #{friendship.friend.full_name}."
  end

  def search
    if params[:friend].present?
      @friend = params[:friend]
      if @friend
        respond_to do |format|
          format.js { render partial: 'friendships/friend_result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = 'Could not find user'
          format.js { render partial: 'friendships/friend_result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = 'This field cannot be empty.'
        format.js { render partial: 'friendships/friend_result' }
      end
    end
  end
end
