<h1>Ninja-Checkers</h1>

![ninja-dojocat](https://camo.githubusercontent.com/20232135c459ea65f3b35e4c779725bc789b4c9c/687474703a2f2f6f63746f6465782e6769746875622e636f6d2f696d616765732f646f6a6f6361742e6a7067)


<p>Ruby Version 2.1.5p273 (2014-11-13 revision 48405) [x86_64-darwin14.0]</p>

<p>API endpoint: <strong> https://ninja-checkers.herokuapp.com </strong></p>

<h2> Create a User </h2>

<h5>Request</h5>

`POST /users`

```json
"user": {
	"email": "spencer@aol.com",
	"password": "SpencersKitty",
	"username": "spencerHatesCats"
}
```
<h5>response</h5>

`Status: 201 Created`

creates a new user. returns an authentication token.
```json
{
"user": {
		 "email": "spencer@aol.com",
		 "username": "spencerHatesCats"
		}
}
```
error examples:
`Status: 422 unprocessable_entity`

```json
"errors": {
	"message": "authentication failed"
}

{
"messages": [
	"Password is too short (minimum is 8 characters)"
		]
}
```


<h2>User Sign in</h2>

<h5>Request</h5>


`POST /users/sign_in`

```json
"user": {
	"email": "spencer@gmail.com",
	"password": "SpencersKitty",
}
```

allows a user to sign in.

<h5>Response</h5>

`Status: 200 OK`

```json
{
	"user": {
			 "username": "gwendolyn",
			 "email": "kelli_volkman@kutch.com",
			 "authentication_token": "dM8zPqM-gJhjGcBiuTzU",
			 "wins": 50,
			 "losses": 12,
			 "forfeits": 13,
			 "level": 0,
			 "experience": 723,
			 "division": "Minor",
			 "current_games": [
			 					{
			 					"id": 83,
			 					"players_count": 2,
			 					"winner_id": "nil",
			 					"board": [
			 								[0, 2, 0 ,2, 0, 2, 0, 2],
                							[2, 0, 2, 0, 2, 0, 2, 0],
                							[0, 2, 0, 2, 0, 2, 0, 2],
                							[0, 0, 0, 0, 0, 0, 0, 0],
                							[0, 0, 0, 0, 0, 0, 0, 0],
                							[1, 0, 1, 0, 1, 0, 1, 0],
                							[0, 1, 0, 1, 0, 1, 0, 1],
                							[1, 0, 1, 0, 1, 0, 1, 0]
                							],
                				"finished": false
                				},

                				{
			 					"id": 65,
			 					"players_count": 2,
			 					"winner_id": "nil",
			 					"board": [
			 								[0, 2, 0 ,2, 0, 2, 0, 2],
                							[2, 0, 2, 0, 2, 0, 2, 0],
                							[0, 2, 0, 2, 0, 2, 0, 2],
                							[0, 0, 0, 0, 0, 0, 0, 0],
                							[0, 0, 0, 0, 0, 0, 0, 0],
                							[1, 0, 1, 0, 1, 0, 1, 0],
                							[0, 1, 0, 1, 0, 1, 0, 1],
                							[1, 0, 1, 0, 1, 0, 1, 0]
                							],
                				"finished": false
                				}
                			]
            }
}
```

example errors:
`Status: 401 unauthorized`

```json
"errors": {
	"message": "authentication failed"
}
```


<h2>User Sign Out</h2>

`DELETE /users/sign_out`

Signs a user out. ##### sign out is not returning any response at the moment ####


<h2>Create a Game</h2>

<h5>Request</h5>

`POST /games`

```json
{
	"authentication_token": "CjsyXUPfxM3Ta3qtBBxd"
}
```

creates a new game. Returns the board.

<h5>Response</h5>

`Status: 201 Created`

```json
{
  "game": {
  	"id": 124,
  	"players": [
  			{
  			   "id": 184,
  			   "user_id": 80,
  			   "game_id": 124
  			}
  	    ],
  	"finished": false,
  	"board":  [
  			[0, 2, 0 ,2, 0, 2, 0, 2],
            [2, 0, 2, 0, 2, 0, 2, 0],
            [0, 2, 0, 2, 0, 2, 0, 2],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0],
            [1, 0, 1, 0, 1, 0, 1, 0],
            [0, 1, 0, 1, 0, 1, 0, 1],
            [1, 0, 1, 0, 1, 0, 1, 0]
  		    ]
  	    }
}
```

<h2>Join a Game</h2>

<h5>Request</h5>

`POST /games/id`

```json
{
	"authentication_token": "CjsyXUPfxM3Ta3qtBBxd"
}
```

allows a user to join a game in waiting. Returns the board.

<h5>Response</h5>

`Status: 200 OK`

```json
{
	"game": {
		"id": 1,
		"players": [
			{
				"game_id": 1,
				"id": 1,
				"user_id": 2
			},
			{
				"id": 4,
				"user_id": 21,
				"game_id": 1
			}
		],
		"finished": false,
		"board": [
				[0, 2, 0 ,2, 0, 2, 0, 2],
                [2, 0, 2, 0, 2, 0, 2, 0],
                [0, 2, 0, 2, 0, 2, 0, 2],
                [0, 0, 0, 0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0, 0, 0, 0],
                [1, 0, 1, 0, 1, 0, 1, 0],
                [0, 1, 0, 1, 0, 1, 0, 1],
                [1, 0, 1, 0, 1, 0, 1, 0]
			 ]
		}
}
```

example errors:
`Status: 422 Unprocessable Entity`

<h2>Challenge a Player</h2>

<h5>Request</h5>

`POST /users/:id/games`

```json
{
"authentication_token": "CjsyXUPfxM3Ta3qtBBxd"
}
```

`:id` is the user_id of the player being challenged, you must send the `authentication_token` of the user that is challenging another user. This allows a user to challenge another user. Returns the board.

<h5>Response</h5>

`Status: 201 Created`

```json
{
"game": {
	"id": 66,
  	"players": [
        {
           "id": 67,
           "user_id": 18,
           "game_id": 65
        },
        {
           "id": 68,
           "user_id": 1,
           "game_id": 65
        }
    ],
  	"finished": false,
	"board": [
				[0, 2, 0 ,2, 0, 2, 0, 2],
                [2, 0, 2, 0, 2, 0, 2, 0],
                [0, 2, 0, 2, 0, 2, 0, 2],
                [0, 0, 0, 0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0, 0, 0, 0],
                [1, 0, 1, 0, 1, 0, 1, 0],
                [0, 1, 0, 1, 0, 1, 0, 1],
                [1, 0, 1, 0, 1, 0, 1, 0]
			 ]
		}
}
```

example errors:
`Status: 422 Unprocessable Entity`


<h2>Leaderboard</h2>

<h5>Request</h5>

`GET /leaderboard`

```json
{
  "authentication_token": "YBbk7q4FRXztrskezRzi"
  }
```

<h5>Response</h5>

`Status: 201 CREATED`

```json
[
	{
	"user": {
			"username": "sienna",
			"email": "isobel@gaylordbogan.com",
			"authentication_token": "LxsTttF83WXpYRhkoUAs",
			"wins": 99,
			"losses": 30,
			"forfeits": 10
			}
	},
	{
	"user": {
			"username": "grant",
			"email": "shea_kuphal@gleichner.com",
			"authentication_token": "azg_B4ePdZbxKFpXriwS",
			"wins": 99,
			"losses": 66,
			"forfeits": 16
			}
	},
	{
	"user": {
			"username": "armani.boyer",
			"email": "amos@lang.biz",
			"authentication_token": "3z5Dauk-FQ65iLf5Lot7",
			"wins": 98,
			"losses": 70,
			"forfeits": 10
			}
	}

]

```


<h2>Pick a Move on the Board</h2>

<h5>Request</h5>

`PATCH /games/:id`

```json
"authentication_token": "CjsyXUPfxM3Ta3qtBBxd"
"pick": {
	"token_start": "[5,2]",
	"token_end": "[4,1]"
}
```

allows a player to pick a move on the board, returns board with updated pieces if its a valid move.

<h5>Response</h5>

`Status: 200 OK`

```json
{
"game": {
	"valid_move": 1,
	"id": 66,
  	"finished": false,
  	"piece_count": {
          "1": 8,
          "2": 7
          },
	"board": [
				[0, 2, 0 ,2, 0, 2, 0, 2],
                [2, 0, 2, 0, 2, 0, 2, 0],
                [0, 2, 0, 2, 0, 2, 0, 2],
                [0, 0, 0, 0, 0, 0, 0, 0],
                [0, 1, 0, 0, 0, 0, 0, 0],
                [1, 0, 0, 0, 1, 0, 1, 0],
                [0, 1, 0, 1, 0, 1, 0, 1],
                [1, 0, 1, 0, 1, 0, 1, 0]
			 ]
		}
}
```

example errors:
`Status: 422 Unprocessable Entity`


<h3>player making multiple moves</h3>
<p>if the game board looks like:  </p>

```json
 [[0, 2, 0, 2, 0, 2, 0, 2],
  [2, 0, 2, 0, 2, 0, 0, 0],
  [0, 2, 0, 2, 0, 2, 0, 2],
  [0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 2, 0, 0, 0, 0],
  [1, 0, 1, 0, 1, 0, 1, 0],
  [0, 1, 0, 1, 0, 1, 0, 1],
  [1, 0, 1, 0, 1, 0, 1, 0]]
```
<p> you can send multiple moves in the token_end param using comma seperators. At the moment, you have to surround the moves in an array, we are working on making this easier to implement. <strong>this move involves player 1 jumping two pieces</strong></p>

<h5>request</h5>

```json
"authentication_token": "mc7LqfF-X3LoU2sxLzM5"
"pick": {
	"token_start": "[5,2]",
	"token_end": "[[3,4],[1,6]]"
}
```


<h5>response</h5>
```json
{
	"game": {
		"valid_move": 1,
		"id": 3,
		"finished": false,
		"piece_count": {
				"1": 12,
				"2": 10
				},
		"board":[ 
				[0, 2, 0, 2, 0, 2, 0, 2],
				[2, 0, 2, 0, 2, 0, 1, 0],
				[0, 2, 0, 2, 0, 0, 0, 2],
				[0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0],
				[1, 0, 0, 0, 1, 0, 1, 0],
				[0, 1, 0, 1, 0, 1, 0, 1],
				[1, 0, 1, 0, 1, 0, 1, 0]
				]

			}
}

<h2>Return users currently online</h2>

<h5>Request</h5>

`GET /users/online`
`"authentication_token": "CjsyXUPfxM3Ta3qtBBxd"`

returns a list of users that have made a request (been authenticated) in the last 5 minutes.

<h5>Response</h5>

```json
[
	{
	"user": {
		"username": "fake_user_2",
		"email": "meggie@hodkiewicz.com",
		"authentication_token": "eSdF3Sx_t9SyS6VKNTHc",
		"wins": 61,
		"losses": 52,
		"level": 1,
		"forfeits": 3,
		"experience": 716,
		"division": "Minor",
		"last_seen": "2015-02-23T19:37:38.304Z"
		}
	},
	{
	"user": {
		"username": "fake_user_9",
		"email": "astrid.paucek@mcclureoconnell.com",
		"authentication_token": "cX9ZhpkJ4k6ZYZfnMudy",
		"wins": 69,
		"losses": 91,
		"level": 3,
		"forfeits": 14,
		"experience": 293,
		"division": "Minor",
		"last_seen": "2015-02-23T19:37:21.775Z"
		}
	},
	{
	"user": {
		"username": "Will16",
		"email": "will16@aol.com",
		"authentication_token": "-oxrVrxUE4taywthTcHR",
		"wins": 0,
		"losses": 0,
		"level": 1,
		"forfeits": 0,
		"experience": 0,
		"division": null,
		"last_seen": "2015-02-23T19:36:49.143Z"
		}
	}
]
```
