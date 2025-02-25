# ConnectU

## Introduction

ConnectU is a brief 2 week project where we intend to create a social media style web application within Ruby on Rails, given a biref specification, our task is to have an index of all posts, users having their own walls where their posts and the posts of others on their wall can be seen and additionally comments on all those posts.

## Quickstart

First, clone this repository. Then:

```bash
> bundle install
> bin/rails db:create
> bin/rails db:migrate

> bundle exec rspec # Run the tests to ensure it works
> bin/rails server # Start the server at localhost:3000
```


## Clearance
Clearance is being used to manage User registration.
This page has details on how to override some of the default behaviour (ie. redirects after signing in ).
Unfortunately it isn't that up to date.
https://github.com/thoughtbot/clearance/wiki/Usage


The [readme](https://github.com/thoughtbot/clearance) suggests to override the default clearance routes.
Thus we ran `rails generate clearance:routes` which added `config.routes = false` to the `/config/initializers/clearance.rb` file and a whole bunch of stuff to `/config/routes.rb`.

We then created `/app/controllers/users_controller.rb` which inherits the clearance Users controller and overwrites the `url_after_create` method to allow custom redirects. (We may add further overwrites to this file)

To ensure the router uses our controller we changed `/config/routes.rb`, namely
`resources :users, controller: 'clearance/users', only: [:create] do`
to
`resources :users, controller: 'users', only: [:create] do`


!!!

Added `require 'clearance/rspec'` to rails helper.
This allows the clearance helper methods to be used.

Added `require 'support/features/clearance_helpers'` to rails helper.
This allows the clearance helper methods to be used even when the spec file is called individually (which wasn't happening before).tests
This slows down rspec slightly.



### Testing

Ran `rails generate clearance:specs` which added tests for user functionality (thanks clarence!)
Unfortunately needed a factory gem.
Ran `gem install factory_bot_rails`
Methods such as `sign_in` and `sign_out` now available in Rspec tests, in particular the controller tests.

Added `Rails.application.routes.default_url_options[:host] = '???'` to `/config/application.rb` which sets this for all of the environments (prod/dev/test). This was required to allow the 'Visitor resets password with valid email' test to pass.
TODO: Should probably be changed for production.
[Answer found here](https://stackoverflow.com/questions/18742779/actionviewtemplateerror-missing-host-to-link-to#18742821)



## Travis CI
NB: There is a difference between .org and .com

Check deployment.

https://travis-ci.com/dtrts/acebook-ConnectU


https://docs.travis-ci.com/user/tutorial/
https://docs.travis-ci.com/user/deployment/heroku/




## Code Climate
https://codeclimate.com/repos/5d7658b000ca3e0177007b30
Reviews quality of repo

=======
## Heroku
```
brew install heroku
```
Once you have a heroku account you can host your own via these commands:
```
heroku create
git push heroku master
heroku rake db:migrate
heroku open /posts
```

Our app is deployyed at: acebook-connectu.herokuapp.com


## Database Development

If you need to play with the development database in IRB you can use these commands to get stuck in with the orm.

Make sure you have a database first!
Add on any additional models if needed.

```
require 'active_record'
require 'clearance'
ActiveRecord::Base.establish_connection(adapter: 'postgresql', database:'pgapp_development')
require_relative './app/models/application_record.rb'
require_relative './app/models/user.rb'
require_relative './app/models/post.rb'
```

## Running Tests

We are using RSpec as our chosen testing framework for this projects; to run the suites, head to the main directory for the application and call the following command in your terminal;

```bash
rspec
```

You should, after a brief pause, see all of our suites, grouped by their feature followed by their descriptions and passes or fails.
