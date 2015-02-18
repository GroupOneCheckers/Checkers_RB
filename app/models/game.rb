class Game < ActiveRecord::Base
  serialize :board

  has_many :players
  has_many :users, through: :players

  validates_length_of :users, maximum: 2, message: "you can only have two players."

  def as_json(opts={})
    super(:only => [:board, :turn_count])
  end
end
