class GamesController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :set_game, only: [:join, :update]

  def index
    @games = Game.active.sort_by(&:piece_count)
    @joinable_games = Game.waiting
    render "games/available_and_active_games.json.jbuilder", status: :ok
  end

  def update
    board_before_move = @game.board.map(&:deep_dup)
    token_end_params.flatten.count == 2 ? 
    token_moves = [token_start_params] + [token_end_params] : 
    token_moves = [token_start_params] + token_end_params
    @game.pick_move(current_user, token_moves)
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

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def token_start_params
    token_start = params.require(:pick).permit(:token_start)
    JSON.parse(token_start['token_start'])
  end

  def token_end_params
    binding.pry
    token_end = params.require(:pick).permit(:token_end)
    JSON.parse(token_end['token_end'])
  end

  def token_path_params
    token_path = params.require(:pick).permit(:token_path)
    moves = JSON.parse(token_path['token_path'])
  end
end
