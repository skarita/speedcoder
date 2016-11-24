# SpeedCoder
[http://speedcoder.herokuapp.com/](http://speedcoder.herokuapp.com/)

## Team
* [skarita](https://github.com/skarita)
* [jamesmah](https://github.com/jamesmah)
* [paulmorello](https://github.com/paulmorello)
* [ppteixeira](https://github.com/ppteixeira)

## Technologies used
HTML, CSS, Bootstrap, Javascript, jQuery, Ruby on Rails, ActiveRecord, BCrypt, NPM, Browserify, PostgreSQL

---
*-- 24 November 2016 --*

##Deployment instructions

```
$ heroku create speedcoder
$ heroku buildpacks:set heroku/ruby
$ heroku buildpacks:add --index 1 heroku/nodejs
$ git push heroku master
$ heroku run rails db:migrate
$ heroku run rails db:seed
```

## Notes

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...