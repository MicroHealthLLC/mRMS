require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  let(:valid_session) { {} }
  login_user

  describe "GET /show" do
    it 'return error' do
      channel = create_channel
      report  = create_report(channel)
      get :show, params: {channel_id: channel.id, id: 0 }, session: valid_session
      expect(response.status).to eq(404)
    end
  end

  describe "GET /show" do
    it 'return success' do
      channel = create_channel
      report  = create_report(channel)
      get :show, params: {channel_id: channel.id, id: report.id }, session: valid_session
      expect(response).to be_successful
    end
  end

end
