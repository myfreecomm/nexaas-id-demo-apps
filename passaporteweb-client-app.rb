require 'sinatra/base'

class PassaporteWebClientApp < Sinatra::Base
  enable :sessions, :logging

  helpers do
    def signed_in?
      !session[:access_token].nil?
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
    OAuth2::AccessToken.new(client, session[:access_token], :refresh_token => session[:refresh_token])
  end

  def redirect_uri
    "http://localhost:#{ENV['PORT']}/callback"
  end

  get '/' do
    erb :home
  end

  get '/sign_in' do
    scope = params[:scope] || 'public'
    redirect client.auth_code.authorize_url(:redirect_uri => redirect_uri, :scope => scope)
  end

  get '/sign_out' do
    session[:access_token] = nil
    session[:access_token]  = nil
    session[:refresh_token] = nil
    session[:info] = nil
    redirect '/'
  end

  get '/callback' do
    new_token = client.auth_code.get_token(params[:code], :redirect_uri => redirect_uri)
    session[:access_token]  = new_token.token
    session[:refresh_token] = new_token.refresh_token
    session[:info] = new_token.get('/api/v1/profile').parsed
    redirect '/'
  end

  get '/refresh' do
    new_token = access_token.refresh!
    session[:access_token]  = new_token.token
    session[:refresh_token] = new_token.refresh_token
    redirect '/'
  end

end
