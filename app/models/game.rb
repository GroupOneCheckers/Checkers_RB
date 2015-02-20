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

  def player1; self.users[0]; end
  def player2; self.users[1]; end

  def pick_move(user, token_start, token_end)
    binding.pry
    x1, y1 = token_start
    if player1 == user && self.board[x1][y1] == 1
      x2 = xBottomCheck(token_start, token_end)
      y2 = yBottomCheck(token_start, token_end)
      if check_integer(x2) && check_integer(y2) && valid_spot?(x2,y2)
        self.board[x1][y1] = 0
        self.board[x2][y2] = 1
        self.save
      else
        move_error
      end
    end
  end

  def valid_spot?(x,y)
    self.board[x][y] == 0 ? true : false 
  end

  def check_integer(index)
    index.is_a?(Integer)
  end

  def xBottomCheck(token_start, token_end)
    x1 = token_start[0]
    x2 = token_end[0]
    if x1 < x2 #
      nil
    elsif x2 > x1 - 1
      nil
    else
      x2
    end
  end

  def yBottomCheck(token_start, token_end)
    x1, y1 = token_start
    x2, y2 = token_end
    if y1 == 0
      x2 == (x1 - 1) && y2 == (y1 + 1) ? y2 : nil
    elsif y1 == 7
      x2 == (x1 - 1) && y2 == (y1 - 1) ? y2 : nil
    elsif y2 == y1 + 1 || y2 == y1 - 1
      y2
    else y2 > y1 + 1 || y2 < y1 - 1
      nil
    end
  end

  def move_error
    "you cant move there"
  end
end
