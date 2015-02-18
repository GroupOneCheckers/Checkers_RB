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

<li> endpoint: 
	<strong>
		https:://ninja-checkers.herokuapp.com 
	</strong>
</li>

<span>API Calls</span>

<h2> Create a User </h2>

<h5>Request</h5>
<pre>
<code>Status: 200 OK
POST /users</code>
</pre>
```json
"user": { 
	"username": "Spencer", 
	"email": "spencer@aol.com",
	"password": "SpencersKitty"
}
```
<h5>response</h5>

```json
{
"user": {
	"email": "spencer@aol.com",
	"authentication_token": "bEazx9CNyTh-3URaMge2"
	}
}
```


creates a new user. returns an authentication token.
<pre>
<code> Status: 422 unprocessable_entity </code>
</pre>
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

<pre>
<code>Status: 200 OK
POST /users/sign_in</code>
</pre>
```json
"user": { 
	"email": "spencer@gmail.com",
	"password": "SpencersKitty",
	"token_auth: "aksfakBJABSFkjbasf"
}
```

allows a user to sign in.

<h5>Response</h5>
```json
{
"user": {
	"email": "brit@gmail.com",
	"authentication_token": "MMrgfMFPz-S14qomLdyX"
	}
}
```json

<pre>
<code> 401 unauthorized</code>
</pre>
```json
"errors": {
	"message": "authentication failed"
}
```


<h2>User Sign Out</h2>

<pre>
<code>Status: 200 OK
DELETE /users/sign_out</code>
</pre>

Signs a user out. #####sign out is not returning any response at the moment####


