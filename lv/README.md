# Lv

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`
  
In order to socket connection to work in local environment, you will need to setup a valid certificate and nginx running on https.

Add the domain to the systems `/etc/hosts`

```
live.amcodev.me  127.0.0.1
```

Add this project nginx conf under `config/vhost.conf` on your global vhost configuration.

Ensure that the app vhost config is configured with the right domain and ports.

```
upstream livedemo {
  server live.amcodev.me:4043;
}

server {
  ssl on;
  listen 443;
  server_name live.amcodev.me;
  ...
```

Build or obtain an ssl certificate signed by a trusted CA. and set it up on the app `vhost.conf` 

```
  ssl_certificate /path/to/your/server.crt;
  ssl_certificate_key /path/to/your/ssl/server.key;
```

Configure paths for https config in `config/dev.exs`

```
  https: [port: 4043,
          keyfile: "/path/to/your/server.key",
          certfile: "/path/to/your/server.crt"
          ],
```

Check that the disered domain is setup in apps `config/config.exs`

```
config :lv, LvWeb.Endpoint,
  url: [host: "live.amcodev.me"],
```

configre the database credentials in  `config/dev.exs`

```
# Configure your database
config :lv, Lv.Repo,
  username: "username",
  password: "password",
  database: "lv_dev",
  hostname: "localhost",
  pool_size: 10
```

Now you can visit [`live.amcodev.me`](https://live.amcodev.me) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
