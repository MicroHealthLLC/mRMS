module OmniauthPatch
  module InstanceMethods
    def client
      case options.name.to_s
        when 'google_oauth2'
          options.client_id = Setting["GOOGLE_KEY"]
          options.client_secret = Setting["GOOGLE_SECRET"]
        when 'microsoft_graph_auth'
          options.client_id = Setting["AZURE_KEY"]
          options.client_secret = Setting["AZURE_SECRET"]
        else
          options.client_id = Setting["#{options.name.upcase}_KEY"]
          options.client_secret = Setting["#{options.name.upcase}_SECRET"]
      end
      super
    end
  end
end
