json.game do
  json.valid_move 1
  json.id @game.id
  json.finished @game.finished
  json.piece_count @game.piece_count
  json.board @game.board
end