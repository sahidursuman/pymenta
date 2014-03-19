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

1. Install railsinstaller (www.railsinstaller.org)

2. Install git

1. Clone the repository

  `git clone https://github.com/manfergo25/pymenta.git`

2. Configure your database in config/database.yml The current config assumes a custom local SQLite configuration.

   `edit config/database.yml`

3. Start your webserver

  `rails s`

Using Heroku
------------------

In order to use heroku, you need to:

  1. Download the heroku toolbelt for windows at https://toolbelt.heroku.com/

  2. Install

  3. Log in using the email address and password you used when creating your Heroku account

  4. Create --> heroku create

  5. Deploy --> git push heroku master ( if you get Permission denied (publickey) --> heroku keys:add )

  6. Migrate --> heroku run rake db:migrate


