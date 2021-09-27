class AuthController < ApplicationController

  def callback
    code = params[:code]

    options = { :body =>
      { "client_id" => "#{Setting['AZURE_KEY']}",
        "redirect_uri" => "#{Setting['CALLBACK_URL']}/auth/microsoft_graph_auth/callback",
        "client_secret" => "#{Setting['AZURE_SECRET']}",
        "code" => "#{code}",
        "scope" => "files.readwrite.all",
        "grant_type" => "authorization_code"
      },
      :headers => { 'Content-Type' => 'application/x-www-form-urlencoded'}
    }

    results = HTTParty.post("https://login.microsoftonline.com/common/oauth2/v2.0/token", options)
    current_user.update!(onedrive_access_token: results.parsed_response["access_token"], onedrive_refresh_token: results.parsed_response["refresh_token"])

    data = session[:data].deep_symbolize_keys
    session.delete(:data)
    flash[:notice] = "Re-Authenticated! Now you can refresh data from One Drive."
    redirect_to channel_report_path(data[:c_id], data[:r_id])
  end
end
