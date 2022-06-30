class FriendshipsController < ApplicationController
  def index
    @friendships = Friendship.where(user_id: current_user.id)
  end

  def destroy
    friendship = Friendship.find(params[:id])
    friendship.destroy
    redirect_to friendships_path, notice: "You are not already tracking #{friendship.friend.full_name}."
  end
end
