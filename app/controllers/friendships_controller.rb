class FriendshipsController < ApplicationController
  def index
    @friendships = Friendship.where(user: current_user).includes(friend: [:user_stocks, :stocks])
  end

  def create
    friend = User.find(params[:friend])
    friendship = Friendship.create(user: current_user, friend: friend)
    redirect_to friendships_path, notice: "You are now following #{friend.full_name}."
  end

  def destroy
    friendship = Friendship.find(params[:id])
    friendship.destroy
    redirect_to friendships_path, notice: "You are not already tracking #{friendship.friend.full_name}."
  end

  def search
    if params[:friend].present?
      @friends = User.where.not(id: current_user.id).search(params[:friend])
      if @friends
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
