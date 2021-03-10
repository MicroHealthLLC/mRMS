class AuthController < ApplicationController

  def callback
    code = params[:code]

    options = { :body =>
      { "client_id" => "#{ENV['AZURE_APP_ID']}",
        "redirect_uri" => "http://localhost:3000/auth/microsoft_graph_auth/callback",
        "client_secret" => "#{ENV['AZURE_APP_SECRET']}",
        "code" => "#{code}",
        "scope" => "files.readwrite.all",
        "grant_type" => "authorization_code"
      },
      :headers => { 'Content-Type' => 'application/x-www-form-urlencoded'}
    }

    results = HTTParty.post("https://login.microsoftonline.com/common/oauth2/v2.0/token", options)
    current_user.update!(onedrive_access_token: results.parsed_response["access_token"], onedrive_refresh_token: results.parsed_response["refresh_token"])

    redirect_to one_drives_path
  end
end
