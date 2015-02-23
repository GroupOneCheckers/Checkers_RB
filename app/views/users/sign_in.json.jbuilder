json.user do
  json.username @user.username
  json.email @user.email
  json.authentication_token @user.authentication_token
  json.wins @user.wins
  json.losses @user.losses
  json.forfeits @user.forfeits
  json.level @user.level
  json.experience @user.experience
  json.division @user.division
  json.current_games @user.games.active
end
