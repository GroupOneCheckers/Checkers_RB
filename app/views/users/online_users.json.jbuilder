json.array! @users do |user|
  json.user do
    json.username user.username
    json.email user.email
    json.authentication_token user.authentication_token
    json.wins user.wins
    json.losses user.losses
    json.level user.level
    json.forfeits user.forfeits
    json.experience user.experience
  	json.division user.division
    json.last_seen user.last_seen
  end
end
