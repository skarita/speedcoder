# SpeedCoder
[http://speedcoder.herokuapp.com/](http://speedcoder.herokuapp.com/)

## Technologies used
HTML, CSS, SCSS, Bootstrap, Javascript, jQuery, Ruby on Rails, ActiveRecord, BCrypt, NPM, Browserify, PostgreSQL, Heroku

## Team
* [skarita](https://github.com/skarita)
* [jamesmah](https://github.com/jamesmah)
* [paulmorello](https://github.com/paulmorello)
* [ppteixeira](https://github.com/ppteixeira)

---
*-- 25 November 2016 --*

## Goal
The goal of this project is to build a website that enables users to practice typing, record their performance, and rank themselves on a leaderboard. We took up the challenge in working on the project in a small team of four to build an API and a front end that consumes it. We aimed to use the Agile development technique to define requirements and tasks, and facilitate the planning process throughout the project.

## Technical Requirements
* Build an API and a front-end that consumes it
* Consume API by making your front-end with HTML, Javascript, & jQuery
* Craft thoughtful user stories together
* Manage team contributions and collaboration using a standard Git flow on Github
* Layout and style your front-end with clean & well-formatted CSS
* Deploy your application online so it's publically accessible

## Technologies used

#### HTML, CSS, Javascript, Ruby on Rails, BCrypt, PostgreSQL, Heroku

#### SCSS
Enable nesting of element properties to apply separate scss files to different views. Enabled the usage of variables for simple updates to site color themes. Used partials for font imports.

#### Bootstrap
Responsive site and navbar. Consistent styling of components (eg. buttons, inputs, modals).

#### jQuery
Utilised for DOM manipulation for user interaction with the site

#### ActiveRecord
Used to access data from PostgreSQL with specified filters and sorting functions for displaying accurate data on the website.

#### NPM
Node.js is compiled before Ruby to user [browserify](https://github.com/substack/node-browserify) and [html-entities](https://github.com/threedaymonk/htmlentities) npm packages

#### Browserify
Enables usage of require()

## Approach taken
1. Built site diagram, wire frames and user stories
1. Obtained feedback from course instructors and coursemates
1. Revised wire frames
1. Data storage using PostgreSQL
1. Built general layout using html/css
1. Created different views using different data sets from the database
1. User sign up/log in and authentification
1. Incoporating Bootstrap, and improving design using SCSS
1. Debugging and documentation

## Wireframes & User stories
Details are in the '/wireframes' folder

## Challenges
### Sean Karita
* Working in a team environment requires good co-ordination and understanding of everyone's tasks for the project to be built efficiently.
* Trello was used to keep our project organized so we knew what each member of our team was working on and when it was completed.
* Using the bootstrap's responsive layout features whilst customizing it to our own style.

### James Mah
1. Working in a team environment introduced some differences in coding style and knowledge in different functions and libraries. This required some extra time for other members to learn but enabled team members to expand their knowledge and understanding of new tools.
2. Lots of time spent playing table tennis

### Paul Morello
* Understanding what each team member is doing and ensuring each person is being utilised efficiently.
* Managing changes from multiple people.
* Accounting for each individuals working style (planning time, feature importance etc..).
* Learning to use SASS efficiently to optimise CSS.
* Finding a consistent CSS style across the website.

### Pedro Araujo
* Dealing with CSS alignment.
* Creating a feature to show flash messages for successful and unsuccessful operations.
* Creating a password confirmation feature.
* Learning to use SASS.
* Understanding how to use Partials in Rails.

## Future works
1. Using a library for code formatting, color and highlighting rather than just grey text. Codemirror, Aceeditor
1. Using ajax to update page with user score upon finishing a snippet, and less page reloads
1. Multiplayer gaming
1. Updating of WPM during gameplay

## Deployment instructions
```
$ heroku create
$ heroku buildpacks:set heroku/ruby
$ heroku buildpacks:add --index 1 heroku/nodejs
$ git push heroku master
$ heroku run rails db:migrate
$ heroku run rails db:seed
```
