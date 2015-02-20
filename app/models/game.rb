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

  def piece_count
    self.board.flatten.each_with_object(Hash.new(0)) do |piece,count| 
      count[piece] += 1 unless piece == 0
    end
  end

  def pick_move(user, token_start, token_end)
    x1, y1 = token_start
    if player1 == user && self.board[x1][y1] == 1
      x2 = xBottomCheck(token_start, token_end)
      y2 = yBottomCheck(token_start, token_end)
      if checks_pass?(x2,y2)
        update_board(token_start,token_end,1)
      end
    elsif player2 == user && self.board[x1][y1] == 2
      x2 = xTopCheck(token_start, token_end)
      y2 = yTopCheck(token_start, token_end)
      if checks_pass?(x2,y2)
        update_board(token_start,token_end,2)
      end
    else
      move_error
    end
  end

  def update_board(token_start,token_end, player)
    start_row, start_col = token_start
    pick_row, pick_col = token_end
    self.board[start_row][start_col] = 0
    self.board[pick_row][pick_col] = player
    remove_opponent_token(token_start, token_end) if jumped(start_row, pick_row)
    self.save
  end

  def remove_opponent_token(token_start, token_end)
    start_row, start_col = token_start
    pick_row, pick_col = token_end
    self.board[start_row + 1][start_col - 1] = 0 if pick_col == start_col - 2
    self.board[start_row + 1][start_col + 1] = 0 if pick_col == start_col + 2
    self.board[start_row - 1][start_col - 1] = 0 if pick_col == start_col - 2
    self.board[start_row - 1][start_col + 1] = 0 if pick_col == start_col + 2
  end

  def jumped(start_row, pick_row)
    if start_row == pick_row - 2
      true
    elsif start_row == pick_row + 2
      true
    else
      false
    end
  end

  def possible_jump(token_start, token_end)
    x1, y1 = token_start
    x2,y2 = token_end
    x2 == x1 + 2 && board[x1+1][y1+1] == 1 || 
    x2 == x1 + 2 && board[x1+1][y1-1] == 1 ||
    x2 == x1 - 2 && board[x1-1][y1+1] == 2 || 
    x2 == x1 - 2 && board[x1-1][y1-1] == 2 
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

  def end_col_jump_if_true_move_if_valid(token_start, token_end, col_position)
    x1, y1 = token_start
    x2, y2 = token_end
    col_position == 0 ? move = (y1 + 1) : move = (y1 - 1)
    col_position == 0 ? jump = (y1 + 2) : jump = (y1 - 2)
    if x2 == xTopCheck(token_start,token_end) && y2 == move ||
       x2 == xBottomCheck(token_start, token_end) && y2 == move
      y2
    elsif x2 == xTopCheck(token_start,token_end) && y2 == jump ||
          x2 == xBottomCheck(token_start, token_end) && y2 == jump
      y2
    else
      nil
    end
  end

  def jump_if_true_move_if_valid(token_start, token_end)
    x1, y1 = token_start
    x2, y2 = token_end
    if y2 == y1 + 1 || y2 == y1 - 1 
      y2
    elsif y2 == y1 + 2 || y2 == y1 - 2
      y2
    else
      nil
    end
  end

  def xTopCheck(token_start, token_end)
    x1, y1 = token_start
    x2, y2 = token_end
    if x1 > x2 #must move down the board
      nil
    elsif possible_jump(token_start,token_end) #checks if player might be jumping
      x2
    elsif x2 > x1 + 1 #cant move more than one space up the board
      nil
    else #valid move
      x2
    end
  end

  def yTopCheck(token_start, token_end)
    x1, y1 = token_start
    x2, y2 = token_end
    if y1 == 0 #if in column 0, can only move down and to the right
      end_col_jump_if_true_move_if_valid(token_start, token_end, 0)
    elsif y1 == 7 #if in column 7, can only move down and to the left
      end_col_jump_if_true_move_if_valid(token_start, token_end, 7)
    elsif xTopCheck(token_start, token_end)
      jump_if_true_move_if_valid(token_start,token_end) #can only move down and to the right or left
    else y2 > y1 + 1 || y2 < y1 - 1 #can only move down one space
      nil
    end
  end

  def xBottomCheck(token_start, token_end)
    x1 = token_start[0]
    x2 = token_end[0]
    if x1 < x2 #must move up board
      nil
    elsif possible_jump(token_start, token_end) #checks if player might be jumping
      x2
    elsif x2 > x1 - 1 #cant move more than one space up the board
      nil
    else #valid move
      x2
    end
  end

  def yBottomCheck(token_start, token_end)
    x1, y1 = token_start
    x2, y2 = token_end
    if y1 == 0 #if in column 0, can only move up and to the right or jump
      end_col_jump_if_true_move_if_valid(token_start, token_end, 0)
    elsif y1 == 7 #if in column 7, can only move up and to the left or jump
      end_col_jump_if_true_move_if_valid(token_start, token_end, 7)
    elsif xBottomCheck(token_start, token_end) #can only move up and to the right or left or jump
      jump_if_true_move_if_valid(token_start,token_end)
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
