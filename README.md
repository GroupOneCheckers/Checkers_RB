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

API Calls

<h2> Create a User </h2>
<pre>
<code>Status: 200 OK
POST [heroku.com]/users</code>
</pre>
```json
"user": { 
	"username": "Spencer", 
	"email": "spencer@gmail.com",
	"password": "SpencersKitty"
}
```

creates a new user. returns an TokenAuth
<pre>
<code> Status: 422 unprocessable_entity </code>
</pre>
```json
"errors": {
	"message": "authentication failed"
}
```




<h2>User Sign in</h2>

<pre>
<code>Status: 200 OK
POST [heroku.com]/users/sign_in</code>
</pre>
```json
"user": { 
	"email": "spencer@gmail.com",
	"password": "SpencersKitty",
	"token_auth: "aksfakBJABSFkjbasf"
}
```

allows a user to sign in.


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
DELETE [heroku.com]/users/sign_out</code>
</pre>

Signs a user out.


