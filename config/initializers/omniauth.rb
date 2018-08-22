Rails.application.config.middleware.use OmniAuth::Builder do
  provider :nexaas_id,
           ENV['NEXAAS_ID_TOKEN'],
           ENV['NEXAAS_ID_SECRET'],
           client_options: { site: ENV['NEXAAS_ID_URL'] }
end
