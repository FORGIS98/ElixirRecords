# Steps to Run the Application
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup` (check ./config/dev.exs for database name and password if needed)
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * `mix run priv/repo/seeds.exs` to load 3 names (one of them, `admin` is required lated)
  * Start ganache-cli in another terminal `ganache-cli`
  * Start Phoenix endpoint with `mix phx.server`
  * Enter `admin@correo.com` and click `Assitance` to deploy the Smart Contract
  * Then go back to main page and enjoy :3
