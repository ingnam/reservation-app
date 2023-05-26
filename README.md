# README

Quick guide on how to setup the application

* Install the following Ruby and Rails Versions

  `ruby '3.0.0'`

  `rails '7.0.5'`



* Clone the repo from github

* Run `bundle install`

* Create databse and run migration

  `rake db:create db:migrate`

* Run tests

  `rspec spec`

* Start rails app

  `rails s`

* Currently, this app has single endpoint. User postman to send the request to this endpoint and send the paylod in request body

  `POST '/api/v1/reservations'`

