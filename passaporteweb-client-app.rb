require 'sinatra/base'

class PassaporteWebClientApp < Sinatra::Base
  enable :sessions, :logging

  helpers do
    # include Rack::Utils

    def pretty_json(json)
      JSON.pretty_generate(json)
    end

    def signed_in?
      !session[:access_token].nil?
    end
  end

  def client(token_method = :post)
    OAuth2::Client.new(
      ENV['PASSAPORTEWEB_APP_ID'],
      ENV['PASSAPORTEWEB_APP_SECRET'],
      :site => ENV['PASSAPORTEWEB_URL'],
      :token_method => token_method,
    )
  end

  def access_token
    OAuth2::AccessToken.new(client, session[:access_token], :refresh_token => session[:refresh_token])
  end

  def redirect_uri
    'http://localhost:3000/callback'
  end

  get '/' do
    erb :home
  end

  get '/sign_in' do
    scope = params[:scope] || 'public'
    authorize_url = client.auth_code.authorize_url(:redirect_uri => redirect_uri, :scope => scope)
    logger.info ">>> Redirecting to: #{authorize_url}"
    redirect authorize_url
  end

  get '/sign_out' do
    session[:access_token] = nil
    redirect '/'
  end

  get '/callback' do
    logger.info ">>> Callback received."
    logger.info "    HTTP_REFERER: #{request.env['HTTP_REFERER']}"
    logger.info "    QUERY_STRING: #{request.env['QUERY_STRING']}"
    new_token = client.auth_code.get_token(params[:code], :redirect_uri => redirect_uri)
    logger.info ">>> Token: #{new_token.to_hash}"
    session[:access_token]  = new_token.token
    session[:refresh_token] = new_token.refresh_token
    redirect '/'
  end

  get '/refresh' do
    new_token = access_token.refresh!
    logger.info ">>> Token: #{new_token.to_hash}"
    session[:access_token]  = new_token.token
    session[:refresh_token] = new_token.refresh_token
    redirect '/'
  end

  get '/explore/:api' do
    raise "Please call a valid endpoint" unless params[:api]
    begin
      response = access_token.get("/api/v1/#{params[:api]}")
      @json = JSON.parse(response.body)
      erb :explore, :layout => !request.xhr?
    rescue OAuth2::Error => @error
      erb :error, :layout => !request.xhr?
    end
  end

end
