require 'rails_helper'

describe AuthenticationController do
  describe '#create' do
    it 'sets the session[:user_id] and redirects to the projects index' do
      user = create_user
      params = {authentication: {email: user.email, password: user.password}}
      post :create, params
      expect(session[:user_id]).to eq(user.id)
      expect(response).to redirect_to(projects_path)
    end
  end

  describe '#destroy' do
    it 'clears the session object and redirects to the root path' do
      session[:user_id] = 3
      get :destroy
      expect(session.empty?).to eq(true)
    end
  end
end
