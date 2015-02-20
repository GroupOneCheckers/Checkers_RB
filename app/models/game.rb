class Game < ActiveRecord::Base
  has_many :players
  has_many :users, through: :players

  after_create :new_board!

  validates_length_of :users, maximum: 2, message: "you can only have two players."

    def as_json(opts={})
      super(:only => [:id, :board])
    end

  INITIAL_BOARD = [[0, 2, 0 ,2, 0, 2, 0, 2],
                   [2, 0, 2, 0, 2, 0, 2, 0],
                   [0, 2, 0, 2, 0, 2, 0, 2],
                   [0, 0, 0, 0, 0, 0, 0, 0],
                   [0, 0, 0, 0, 0, 0, 0, 0],
                   [1, 0, 1, 0, 1, 0, 1, 0],
                   [0, 1, 0, 1, 0, 1, 0, 1],
                   [1, 0, 1, 0, 1, 0, 1, 0]]

  serialize :board

  def self.waiting
    Game.where(:players_count => 1)
  end

  def self.active
    Game.where(:finished => false)
  end

  def new_board!
    self.update_attribute :board, INITIAL_BOARD
  end

  def pick_move(user, token_start, token_end)
    x1, y1 = token_start
    if player1 == user && self.board[x1][y1] == 1
      x2 = xBottomCheck(token_start, token_end)
      y2 = yBottomCheck(token_start, token_end)
      if checks_pass?(x2,y2)
        update_board(x1,y1,x2,y2,1)
      end
    elsif player2 == user && self.board[x1][y1] == 2
      binding.pry
      x2 = xTopCheck(token_start, token_end)
      y2 = yTopCheck(token_start, token_end)
      if checks_pass?(x2,y2)
        update_board(x1,y1,x2,y2,2)
      end
    else
      move_error
    end
  end

  def update_board(start_row, start_col, pick_row, pick_col, player)
    binding.pry
    self.board[start_row][start_col] = 0
    self.board[pick_row][pick_col] = player
    self.save
  end

  def checks_pass?(x,y)
    check_integer(x) && check_integer(y) && valid_spot?(x,y)
  end

  def valid_spot?(x,y)
    self.board[x][y] == 0 ? true : false 
  end

  def check_integer(index)
    index.is_a?(Integer)
  end

  def xTopCheck(token_start, token_end)
    x1 = token_start[0]
    x2 = token_end[0]
    if x1 > x2 #must move down board
      nil
    elsif x2 > x1 + 1 #cant move more than one space down the board
      nil
    else #valid move
      x2
    end
  end

  def yTopCheck(token_start, token_end)
    x1, y1 = token_start
    x2, y2 = token_end
    if y1 == 0 #if in column 0, can only move down and to the right
      x2 == (x1 + 1) && y2 == (y1 + 1) ? y2 : nil 
    elsif y1 == 7 #if in column 7, can only move down and to the left
      x2 == (x1 + 1) && y2 == (y1 - 1) ? y2 : nil
    elsif y2 == y1 + 1 || y2 == y1 - 1 #can only move down and to the right or left
      y2
    else y2 > y1 + 1 || y2 < y1 - 1 #can only move down one space
      nil
    end
  end

  def xBottomCheck(token_start, token_end)
    x1 = token_start[0]
    x2 = token_end[0]
    if x1 < x2 #must move up board
      nil
    elsif x2 > x1 - 1 #cant move more than one space up the board
      nil
    else #valid move
      x2
    end
  end

  def yBottomCheck(token_start, token_end)
    x1, y1 = token_start
    x2, y2 = token_end
    if y1 == 0 #if in column 0, can only move up and to the right
      x2 == (x1 - 1) && y2 == (y1 + 1) ? y2 : nil
    elsif y1 == 7 #if in column 7, can only move up and to the left
      x2 == (x1 - 1) && y2 == (y1 - 1) ? y2 : nil
    elsif y2 == y1 + 1 || y2 == y1 - 1 #can only move up and to the right or left
      y2
    else y2 > y1 + 1 || y2 < y1 - 1 #can only move up one space
      nil
    end
  end

  def player1; self.users[0]; end
  def player2; self.users[1]; end

  def move_error
    "you cant move there"
  end
end
