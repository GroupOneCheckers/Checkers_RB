json.game do
  json.id @game.id
  json.players game.players
  json.finished game.finished
  json.board @game.board
end