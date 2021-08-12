require 'rails_helper'

RSpec.describe NewsController, type: :controller do
  let(:valid_session) { {} }
  login_user
  describe "GET /index" do
    it 'return sucess' do
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it 'return success' do
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    it 'return success' do
      post :create, params: {:news => { :title => "Any Name", :summary => "", :description => "",:user_id => @user }}, session: valid_session
      expect(response).to be_successful
    end
  end
end
