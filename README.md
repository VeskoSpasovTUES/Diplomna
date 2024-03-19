# README

In order to run this app you need the following:

* Ruby version 3.3.0 or newer

* Rails version 7.1.3 or newer

* Chart.js

* SQLite3 version 1.4 or newer

* Yarn version 1.22.19 or newer

After installing everything from the above point following the tutorials you need to open a terminal go into the project directory and run the following commands:

1. bundle install
2. db:migrate
3. rails s

bundle install will install all of the gems used for the project. db:migrate will make the migrations to the database to ensure its structure. rails s will start the server on the localhost.

After that you can get access to the app on http://localhost:3000 in the browser. When you are done you should press ctrl + c in the terminal to terminate the server.
