== README

This README would normally document whatever steps are necessary to get the
application up and running.

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

* ...

API Calls
<pre>
<code>Status: 200 OK
post [heroku.com]/users</code>
</pre>
```json
"user": { 
	"username": "Spencer", 
	"email": "spencer@gmail.com",
	"password": "SpencersKitty"
}
```

creates a new user. returns an TokenAuth

Status: 422 unprocessable_entity

```json
"errors": {
	"message": "authentication failed"
}
```

Here goes your json object definition

