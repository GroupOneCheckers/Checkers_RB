class GamesController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :set_game, only: [:join, :update]


  def update
    board_before_move = @game.board.map(&:deep_dup)
    @game.pick_move(current_user, token_start_params, token_end_params)
    if @game.board != board_before_move
      render json: { :game => @game }, status: :ok
    else
      render json: { messages: @game.move_error}, status: :not_acceptable
    end
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
    @player1 = User.find_by_authentication_token(player1_challenge_params)
    @player2 = User.find_by_authentication_token(player2_challange_params)
    @game = Game.new(users: [@player1, @player2])
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

  def set_game
    @game = Game.find(params[:id])
  end

  def player1_challenge_params
    params.require(:challenge).permit(:authentication_token_p1)
  end

  def player2_challange_params
    params.require(:challenge).permit(:authentication_token_p2)
  end

  def token_start_params
    token_start = params.require(:pick).permit(:token_start)
    JSON.parse(token_start['token_start'])
  end

  def token_end_params
    token_end = params.require(:pick).permit(:token_end)
    JSON.parse(token_end['token_end'])
  end
end
