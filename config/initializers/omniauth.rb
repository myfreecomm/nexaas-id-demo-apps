require "#{Rails.root}/lib/omniauth/strategies/passaporte_web"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :passaporte_web,
           ENV['PASSAPORTE_WEB_ID'],
           ENV['PASSAPORTE_WEB_SECRET'],
           client_options: { site: ENV['PASSAPORTE_WEB_URL'] }
end
