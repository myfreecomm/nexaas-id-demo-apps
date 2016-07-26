require 'sinatra/base'

class PassaporteWebClientApp < Sinatra::Base
  enable :sessions, :logging

  use OmniAuth::Builder do
    provider :passaporte_web,
      ENV['PASSAPORTEWEB_APP_ID'],
      ENV['PASSAPORTEWEB_APP_SECRET'],
      :client_options => {
        :site => ENV['PASSAPORTEWEB_URL'],
      }
  end

  helpers do
    def signed_in?
      !session[:uid].nil?
    end
  end

  def client
    OAuth2::Client.new(
      ENV['PASSAPORTEWEB_APP_ID'],
      ENV['PASSAPORTEWEB_APP_SECRET'],
      :site => ENV['PASSAPORTEWEB_URL'],
    )
  end

  def access_token
    OAuth2::AccessToken.new(
      client,
      session[:access_token],
      :refresh_token => session[:refresh_token]
    )
  end

  get '/' do
    erb :home
  end

  get '/sign_in' do
    scope = params[:scope] || 'public'
    redirect "/auth/passaporte_web?scope=#{scope}"
  end

  get '/sign_out' do
    session[:uid] = nil
    session[:access_token]  = nil
    session[:refresh_token] = nil
    session[:omniauth] = nil
    redirect '/'
  end

  get '/auth/passaporte_web/callback' do
    # origin = request.env['omniauth.origin']
    auth = request.env['omniauth.auth']
    session[:uid]  = auth.uid
    session[:access_token]  = auth.credentials.token
    session[:refresh_token] = auth.credentials.refresh_token
    session[:omniauth] = auth.to_hash
    redirect '/'
  end

  get '/refresh' do
    new_token = access_token.refresh!
    session[:access_token]  = new_token.token
    session[:refresh_token] = new_token.refresh_token
    redirect '/'
  end

end
