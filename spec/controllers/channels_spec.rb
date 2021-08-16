require 'rails_helper'

RSpec.describe ChannelsController, type: :controller do
  let(:valid_session) { {} }
  login_user

  describe "response with 404 if page not found" do
    it 'return page not found' do
      get :index, params: {}, session: valid_session
      expect(response.status).to eq(404)
    end
  end

  describe "POST /create" do
    it 'return success' do
      post :create, params: {:channel => { :name => "Any Name", :is_public => true, :description => "",:user_id => @user }}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it 'return success' do
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it 'return success' do
      channel = create_channel
      get :edit, params: {id: channel.id}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it 'return success' do
      channel = create_channel
      get :show, params: {id: channel.id}, session: valid_session
      expect(response).to be_successful
    end
  end

  # describe "PUT /update" do
  #   it "return success" do
  #     channel = create_channel
  #     put :update, params: {:channel => { id: channel.id ,:name => "Updated Name", :is_public => true,:user_id => @user.id } },session: valid_session
  #     expect(response).to be_successful
  #   end
  # end
end
