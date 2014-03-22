Pymenta Rails Project
===========================================================

Pymenta is a very simple Cloud ERP System created for small companies to create, 
manage and print documents ( invoices, notes, quotations, credits, etc). 
You can manage warehouses, providers and clients. Also products and stock. 
Print Statistic Reports. Designed to work in the Cloud. 

Demo Application
----------------

A demo application can be found at http://pymenta.herokuapp.com/

Local Installation
------------------

1. Download and install railsinstaller (git is included)--> www.railsinstaller.org

2. Clone the repository

  `git clone https://github.com/manfergo25/pymenta.git`

3. Configure your database in config/database.yml The current config assumes a custom local SQLite configuration.

   `edit config/database.yml`

4. Install gems

  `bundle`

5. Migrate database

  `rake db:migrate`

6. Start your webserver

  `rails s`

Using Heroku
------------------

In order to use heroku, you need to:

  1. Download and install the heroku toolbelt for windows at https://toolbelt.heroku.com/

  2. Log in using the email address and password you used when creating your Heroku account

  3. Create an application

	`heroku create`

  4. Deploy the application
 	
	`git push heroku master ( if you get Permission denied (publickey) --> heroku keys:add )`

  5. Migrate database

	`heroku run rake db:migrate`


