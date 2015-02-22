json.array! @games do |game|
  json.game do
    json.id game.id
  	json.players game.players
  	json.finished game.finished
    json.piece_count game.piece_count
    json.board game.board
  end  
end

json.array! @joinable_games do |game|
  json.game do
    json.id game.id
  	json.player game.players[0]
  	json.finished game.finished
    json.board game.board
  end  
end