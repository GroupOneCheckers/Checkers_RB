class GamesController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :set_game, only: [:show, :join]


  def update
    
  end

  def join
    @game.users << current_user
    if @game.save
      render json: { :game => @game}, status: :ok
    else
      render json: { messages: @game.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def create
    @game = Game.new(users: [current_user])
    if @game.save
      render json: {game: @game}, status: :created
    else
      render json: {messages: @game.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def challenge
    @user = User.find(params[:id])
    @game = Game.new(users: [current_user, @user])
    if @game.save
      render json: {game: @game}, status: :created
    else
      render json: {messages: @game.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def leaderboard
    @users = User.all.order('users.wins DESC').first(25)
    if @users
      render json: { users: @users }, status: :created
    else
      render json: { messages: @users.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:email, :password, :username)
  end

  def set_game
    @game = Game.find(params[:id])
  end
end
