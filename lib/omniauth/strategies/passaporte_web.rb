class OmniAuth::Strategies::PassaporteWeb < OmniAuth::Strategies::OAuth2
  option :name, :passaporte_web

  uid do
    raw_info['id']
  end

  info do
    {
      email: raw_info['email'],
      name: raw_info['name'],
      picture_url: raw_info['picture'],
    }
  end

  def raw_info
    @raw_info ||= access_token.get('/api/v1/profile.json').parsed
  end
end
