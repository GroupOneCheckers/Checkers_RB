class GamesController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :set_game, only: [:join, :update]

  def index
    @games = Game.all.where(finished: false).order(:piece_count desc)
    @joinable_games = Game.all.map(&:waiting)
  end


  def update
    board_before_move = @game.board.map(&:deep_dup)
    @game.pick_move(current_user, token_start_params, token_end_params)
    if @game.win?
      render "games/finished.json.jbuilder", status: :ok
    elsif @game.board != board_before_move
      render "games/update_valid.json.jbuilder", status: :ok
    else
      render "games/update_invalid.json.jbuilder", status: :not_acceptable
    end
  end

  def join
    @game.users << current_user
    if @game.save
      render "games/join.json.jbuilder", status: :ok
    else
      render json: { messages: @game.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def create
    @game = Game.new(users: [current_user])
    if @game.save
      render "games/create.json.jbuilder", status: :created
    else
      render json: {messages: @game.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def challenge
    @player2 = User.find(params[:id])
    @game = Game.new(users: [current_user, @player2])
    if @game.save
      render "games/challenge.json.jbuilder", status: :created
    else
      render json: {messages: @game.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def leaderboard
    @users = User.all.order('users.wins DESC').first(25)
    if @users
      render "games/leaderboard.json.jbuilder", status: :created
    else
      render json: { messages: @users.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_game
    @game = Game.find(params[:id])
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
