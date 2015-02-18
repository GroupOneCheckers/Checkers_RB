class Game < ActiveRecord::Base
  serialize :board

  has_many :players
  has_many :users, through: :players

  validates_length_of :users, maximum: 2, message: "you can only have two players."

  def as_json(opts={})
    super(:only => [:board, :turn_count])
  end
end


# board_hash = {1=>[1, 1, 0, 0, 0, 0, 2, 2],
#               2=>[1, 1, 0, 0, 0, 0, 2, 2],
#               3=>[1, 1, 0, 0, 0, 0, 2, 2],
#               4=>[1, 1, 0, 0, 0, 0, 2, 2],
#               5=>[1, 1, 0, 0, 0, 0, 2, 2],
#               6=>[1, 1, 0, 0, 0, 0, 2, 2],
#               7=>[1, 1, 0, 0, 0, 0, 2, 2],
#               8=>[1, 1, 0, 0, 0, 0, 2, 2]}

#  board_array = [[1, 1, 1, 1, 1, 1, 1, 1],
#                 [1, 1, 1, 1, 1, 1, 1, 1],
#                 [0, 0, 0, 0, 0, 0, 0, 0],
#                 [0, 0, 0, 0, 0, 0, 0, 0],
#                 [0, 0, 0, 0, 0, 0, 0, 0],
#                 [0, 0, 0, 0, 0, 0, 0, 0],
#                 [2, 2, 2, 2, 2, 2, 2, 2],
#                 [2, 2, 2, 2, 2, 2, 2, 2]]


#