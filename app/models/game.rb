class Game < ActiveRecord::Base
  has_many :players
  has_many :users, through: :players

  after_create :new_board!

  validates_length_of :users, maximum: 2, message: "you can only have two players."

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

  def win?
    if self.piece_count[1] == 0
      player2.wins += 1
      player1.losses += 1
      player1.save; player2.save
      self.finished == true; self.save
    elsif self.piece_count[2] == 0
      player1.wins += 1
      player2.losses += 1
      player1.save; player2.save
      self.finished = true; self.save
    end
  end

  def pick_move(user, token_moves)
    move_count = token_moves.count - 2
    token_moves[0..move_count].each_with_index do |row_col, i|
      start_row, start_col = row_col[0], row_col[1]
      end_row, end_col = token_moves[i+1][0], token_moves[i+1][1]
      if player1 == user && self.board[start_row][start_col] == 1
        end_row_check = xBottomCheck(start_row, start_col, end_row, end_col)
        end_col_check = yBottomCheck(start_row, start_col, end_row, end_col)
        if checks_pass?(end_row_check, end_col_check)
          update_board(user, start_row, start_col, end_row, end_col,1)
        end
      elsif player2 == user && self.board[start_row][start_col] == 2
        end_row_check = xTopCheck(start_row, start_col, end_row, end_col)
        end_col_check = yTopCheck(start_row, start_col, end_row, end_col)
        if checks_pass?(end_row_check, end_col_check)
          update_board(user, start_row, start_col, end_row, end_col,2)
        end
      else
        move_error
      end
    end
  end

  def update_board(user, start_row, start_col, end_row, end_col, player)
    self.board[start_row][start_col] = 0
    self.board[end_row][end_col] = player
    remove_opponent_token(user, start_row, start_col, end_col) if jumped(start_row, end_row)
    self.save
  end

  def remove_opponent_token(user, start_row, start_col, end_col)
    if player2 == user
      self.board[start_row + 1][start_col - 1] = 0 if end_col == start_col - 2
      self.board[start_row + 1][start_col + 1] = 0 if end_col == start_col + 2
    elsif player1 == user
      self.board[start_row - 1][start_col - 1] = 0 if end_col == start_col - 2
      self.board[start_row - 1][start_col + 1] = 0 if end_col == start_col + 2
    end
  end

  def jumped(start_row, end_row)
    if start_row == end_row - 2
      true
    elsif start_row == end_row + 2
      true
    else
      false
    end
  end

  def possible_jump(start_row, start_col, end_row)
    end_row == start_row + 2 && board[start_row+1][start_col+1] == 1 ||
    end_row == start_row + 2 && board[start_row+1][start_col-1] == 1 ||
    end_row == start_row - 2 && board[start_row-1][start_col+1] == 2 ||
    end_row == start_row - 2 && board[start_row-1][start_col-1] == 2
  end

  def checks_pass?(end_row, end_col)
    check_integer(end_col) && check_integer(end_col) && valid_spot?(end_row, end_col)
  end

  def valid_spot?(end_row, end_col)
    self.board[end_row][end_col] == 0 ? true : false
  end

  def check_integer(index)
    index.is_a?(Integer)
  end

  def first_or_last_col_jump_if_true_move_if_valid(start_row, start_col, end_row, end_col, col_position)
    col_position == 0 ? move = (start_col + 1) : move = (start_col - 1)
    col_position == 0 ? jump = (start_col + 2) : jump = (start_col - 2)
    if end_row == xTopCheck(start_row, start_col, end_row, end_col) && end_col == move ||
       end_row == xBottomCheck(start_row, start_col, end_row, end_col) && end_col == move
      end_col
    elsif end_row == xTopCheck(start_row, start_col, end_row, end_col) && end_col == jump ||
          end_row == xBottomCheck(start_row, start_col, end_row, end_col) && end_col == jump
      end_col
    else
      nil
    end
  end

  def jump_if_true_move_if_valid(start_col, end_col)
    if end_col == start_col + 1 || end_col == start_col - 1
      end_col
    elsif end_col == start_col + 2 || end_col == start_col - 2
      end_col
    else
      nil
    end
  end

  def xTopCheck(start_row, start_col, end_row, end_col)
    if start_row > end_row #must move down the board
      nil
    elsif possible_jump(start_row, start_col, end_row) #checks if player might be jumping
      end_row
    elsif end_row > start_row + 1 #cant move more than one space up the board
      nil
    else #valid move
      end_row
    end
  end

  def yTopCheck(start_row, start_col, end_row, end_col)
    if start_col == 0 #if in column 0, can only move down and to the right
      first_or_last_col_jump_if_true_move_if_valid(start_row, start_col, end_row, end_col, 0) 
    elsif start_col == 7 #if in column 7, can only move down and to the left
      first_or_last_col_jump_if_true_move_if_valid(start_row, start_col, end_row, end_col, 7) 
    elsif xTopCheck(start_row, start_col, end_row, end_col) #can only move down and to the right or left
      jump_if_true_move_if_valid(start_col, end_col) 
    else end_col > start_col + 1 || end_col < start_col - 1 #can only move down one space
      nil 
    end
  end

  def xBottomCheck(start_row, start_col, end_row, end_col)
    if start_row < end_row #must move up board
      nil
    elsif possible_jump(start_row, start_col, end_row) #checks if player might be jumping
      end_row
    elsif end_row < start_row - 1 #cant move more than one space up the board
      nil
    else #valid move
      end_row
    end
  end

  def yBottomCheck(start_row, start_col, end_row, end_col)
    if start_col == 0 #if in column 0, can only move up and to the right or jump
      first_or_last_col_jump_if_true_move_if_valid(start_row, start_col, end_row, end_col, 0)
    elsif start_col == 7 #if in column 7, can only move up and to the left or jump
      first_or_last_col_jump_if_true_move_if_valid(start_row, start_col, end_row, end_col, 7)
    elsif xBottomCheck(start_row, start_col, end_row, end_col) #can only move up and to the right or left or jump
      jump_if_true_move_if_valid(start_col, end_col)
    else end_col > start_col + 1 || end_col < start_col - 1 #can only move up one space
      nil
    end
  end

  def player1; self.users[0]; end
  def player2; self.users[1]; end

  def move_error
    "you cant move there"
  end
end


