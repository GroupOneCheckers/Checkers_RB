json.game do
  json.valid_move 1
  json.board @game.board
  json.id @game.id
  json.piece_count @game.piece_count
end