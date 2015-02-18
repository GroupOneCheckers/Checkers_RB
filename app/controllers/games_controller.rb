class GamesController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :set_game, only: [:show]


  def show
    render json: { :game => @game }, status: :ok
  end

  def join
    binding.pry
    @game = Game.find(params[:id])
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

  private

  def user_params
    params.require(:user).permit(:email, :password, :username)
  end

  def set_game
    @game = Game.find(params[:id])
  end

end
