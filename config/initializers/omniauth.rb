OmniAuth.config.full_host = ENV['CALLBACK_URL']
OmniAuth::Strategies::OAuth2.prepend(OmniauthPatch::InstanceMethods)