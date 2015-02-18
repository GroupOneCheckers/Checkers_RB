class GamesController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :set_game, only: [:show]

  def show
    render json: { :game => @game }, status: :ok
  end

  def join
  end

  def new
    @game.new()
  end

  def create
    @game = Game.new(users: [current_user])
    if @game.save
      render json: {game: @game}, status: :created
    else
      render json: {messages: @gmae.errors.full_messages}, status: :unprocessable_entity
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
