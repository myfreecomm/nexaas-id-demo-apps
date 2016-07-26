# passaporte-web-2-demo-apps

## sinatra-1.4-omniauth

An example Sinatra v1.4 app, which signs in to [PassaporteWeb](http://www.passaporteweb.com.br) via OAuth2 using the [omniauth-passaporte_web gem](https://github.com/myfreecomm/omniauth-passaporte_web).

To run the app, copy `.env.example` to `.env` and change the `PASSAPORTEWEB_*` variables to use your app's Id and Secret from PassaporteWeb.

Then run:

```bash
$ bundle install
$ foreman start
```

Now visit the app on [http://localhost:3000](http://localhost:3000) (unless you've changed the `PORT` on the `.env` file).
