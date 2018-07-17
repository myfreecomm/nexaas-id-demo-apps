class User < ApplicationRecord
  def self.find_or_create_from_pw_oauth(oauth)
    find_or_initialize_by(uid: oauth.uid).tap do |user|
      user.email = oauth.info.email
      user.name = oauth.info.name
      user.picture_url = oauth.info.picture_url
      user.token = oauth.credentials.token
      user.save
    end
  end
end
