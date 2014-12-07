require 'rails_helper'

describe RegistrationsController do
  describe '#new' do
    it 'renders the registration new template' do
      get :new
      expect(response).to render_template('new')
    end
  end
  describe '#create' do
    it 'sets session[:user_id] and redirects to the new project page' do
      user = new_user
      params = {user: { first_name: user.first_name, last_name: user.last_name,
                        email: user.email, password: user.password}}
      post :create, params
      expect(session[:user_id]).to be_present
      expect(response).to redirect_to(new_project_path)
    end
  end
end
