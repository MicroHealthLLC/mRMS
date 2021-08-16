require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  let(:valid_session) { {} }
  login_user
  describe "GET /index" do
    it 'return user not logged-in' do
      sign_out @user
      get :index, params: {}, session: valid_session
      expect(response.status).to eq(302)
    end
  end

  describe "GET /index" do
    it 'return success' do
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end
end
