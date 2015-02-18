<h1>Ninja-Checkers</h1>

![ninja-dojocat](https://camo.githubusercontent.com/20232135c459ea65f3b35e4c779725bc789b4c9c/687474703a2f2f6f63746f6465782e6769746875622e636f6d2f696d616765732f646f6a6f6361742e6a7067)


Things you may want to cover:

* Ruby version
ruby 2.1.5p273 (2014-11-13 revision 48405) [x86_64-darwin14.0]

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

<p>API endpoint: <strong> https://ninja-checkers.herokuapp.com </strong></p>

<h2> Create a User </h2>

<h5>Request</h5>

`POST /users`

```json
"user": { 
	"username": "Spencer", 
	"email": "spencer@aol.com",
	"password": "SpencersKitty"
}
```
<h5>response</h5>

`Status: 200 OK`

creates a new user. returns an authentication token.
```json
{
"user": {
	"email": "spencer@aol.com",
	"authentication_token": "bEazx9CNyTh-3URaMge2"
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
	"email": "brit@gmail.com",
	"authentication_token": "MMrgfMFPz-S14qomLdyX"
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


