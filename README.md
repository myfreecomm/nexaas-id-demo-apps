# PassaporteWeb OmniAuth Client

This application is an example of an OAuth2 web client. It was built in order to test login with
[Nexaas ID](https://id.nexaas.com/).

It uses [Rails 5.2](http://github.com/rails/rails/) and the [OmniAuth](http://github.com/intridea/omniauth) gem.
Nexaas ID strategy is built on top of
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

If you want to authorize your own application created on Nexaas ID's dashboard, you need to change the ID/secret pair.
Your can provide these values in your environment file or change the existent .env.development file:

    # Replace this with your application id
    NEXAAS_ID_TOKEN = N2CTX26NLZCCFK3GO6UYBY2ZPA

    # Replace this with your application secret
    NEXAAS_ID_SECRET = F3S2UTNGRRCFTMVKXWCQNVXR6M

    # Use https://sandbox.id.nexaas.com for sandbox
    # or https://id.nexaas.com for production
    NEXAAS_ID_URL=https://sandbox.id.nexaas.com

Now start the application.

    bin/rails server

