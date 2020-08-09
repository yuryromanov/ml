# README

##Coding challenge 

I deployed the application [heroku](https://murmuring-escarpment-79264.herokuapp.com/admin/). Credentials are `admin@example.com` and `PASS11111`.
I added some test data: `departments`, `employees` and of course 3 `mystery lunches` for 3 months. Feel free to remove or add something on this server.

To create a nice looking interface I used the gem [activeadmin](https://github.com/activeadmin/activeadmin). It covers all requirements like authentication, UI to manage employees, departments and so on.

For tests, I used [rspec](https://github.com/rspec/rspec-rails) framework and nice [factory_bot](https://github.com/thoughtbot/factory_bot). Unfortunately, I spend more time than I expected for this challenge due to the count and size of features. By this reason, I decided to save some time and do not write many tests. I'm sorry about that.

Probably the most complicated part of the application is the algorithm to select partners for mystery lunches. The current implementation is not ideal from my point of view because it does not cover all possible edge-cases I've found during working with this challenge but I think it matches requirements from the provided specification. It works fast and doesn't create a lot of collisions.

The project also has no Dockerfile due to time limitations.

To run this project on your local computer you need to install `ruby-2.6.5` and then do the following:
```
  git clone git@github.com:yuryromanov/ml.git
  cd ml
  bundle install
  rake db:create
  rake db:migrate
  rake db:seed
  rails server
  # and now open address http://localhost:3000 in your browser
```

Have a good review.

Yury Romanov

