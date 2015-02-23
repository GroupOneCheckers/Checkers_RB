class UsersController < ApplicationController
  before_action :authenticate_user_from_token!

  def leaderboard
    @users = User.all.order('users.wins DESC').first(25)
    if @users
      render "users/leaderboard.json.jbuilder", status: :created
    else
      render json: { messages: @users.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def users_online
    @users = User.return_online_users
    if @users.length > 0
      render "users/online_users.json.jbuilder", status: :ok
    else
      render json: { messages: 'no users currently online' }, status: :no_content
    end
  end
  
end