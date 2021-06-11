OmniAuth.config.full_host = Setting['CALLBACK_URL']
OmniAuth::Strategies::OAuth2.prepend(OmniauthPatch::InstanceMethods)
