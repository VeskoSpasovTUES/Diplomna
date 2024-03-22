# README

In order to run this app you need the following:

* Ruby version 3.3.0 or newer

* Rails version 7.1.3 or newer
  
* Node.js version 20.0 or newer

* Chart.js

* SQLite3 version 1.4 or newer

* Yarn version 1.22.19 or newer

After that step you need to go to https://github.com/VeskoSpasovTUES/Diplomna_csv_files and install the "laptimes.csv" file 

After installing everything you need to open a terminal go into the project directory and run the following commands:

1. bundle install
2. db:migrate
3. rake parsers:laptimes["<path_to_csv_file>"]
4. rails s

The first command will install all of the gems used for the project. The second one will make the migrations to the database to ensure its structure. 
The third will import the data from the csv to the database. The final command will rails s will start the server on the localhost.

After that you can get access to the app on http://localhost:3000 in the browser. When you are done you should press ctrl + c in the terminal to terminate the server.
