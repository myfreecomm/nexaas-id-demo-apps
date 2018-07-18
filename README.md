# PassaporteWeb OmniAuth Client

This application is an example of OAuth2 client. It was built in order to test login with
[PassaporteWeb 2](https://v2.passaporteweb.com.br/).

It uses [Rails 5.2](http://github.com/rails/rails/) and the [OmniAuth](http://github.com/intridea/omniauth) gem.
PassaporteWeb strategy is build on top of
[abstract OAuth2 strategy for OmniAuth](https://github.com/intridea/omniauth-oauth2).

It requires Ruby version 2.5.1 or superior.

## Installation & Configuration

If you want to run the application by yourself follow these steps.

First you need to clone the [repository from GitHub](http://github.com/myfreecomm/passaporte-web-2-demo-apps.git)

    git clone git://github.com/myfreecomm/passaporte-web-2-demo-apps.git
    cd passaporte-web-2-demo-apps
    git checkout rails-5.0

Install all the gems:

    bundle install

Create the database:

    rake db:setup

At this point the application should be ready to run.

If you want to authorize your own application created on PassaporteWeb 2 dashboard, you need to change the ID/secret pair.
Your can provide these values in your environment file or change the existent .env.development file:

    # Replace this with your application id
    PASSAPORTE_WEB_ID = N2CTX26NLZCCFK3GO6UYBY2ZPA

    # Replace this with your application secret
    PASSAPORTE_WEB_SECRET = F3S2UTNGRRCFTMVKXWCQNVXR6M

    # Use https://sandbox.v2.passaporteweb.com.br for sandbox
    # or https://v2.passaporteweb.com.br for production
    PASSAPORTE_WEB_URL = https://sandbox.v2.passaporteweb.com.br

Now start the application.

    bin/rails server
