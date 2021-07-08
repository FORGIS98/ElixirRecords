# Steps to Run the Application
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup` (check ./config/dev.exs for database name and password if needed)
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * `mix run priv/repo/seeds.exs` to load the database with some info (check admin name and password, you will needed)
  * Start ganache-cli in another terminal `ganache-cli`
  * Start Phoenix endpoint with `mix phx.server`
  * Enter admin credentials first to deploy the smart contract (top right corner)
  * Then go back to main page and create a user or use an existing one

# TODO
  * At this moment we can deploy smart contracts, but we can't call the smart contract because we get a **revert** error on the VM. The code is written and should work but we can't test it, so one thing is to solve this big issue
  * If we log in with the admin, once we choose an event we will se a pop-up with all the users that are going to assist to the event
