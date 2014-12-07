require 'rails_helper'

describe ProjectsController do

  before [:show, :edit, :update, :destroy] do
    @project = create_project
  end

  describe '#index' do
    it 'renders the index template' do
      session[:user_id] = create_user.id
      get :index
      expect(response).to render_template('index')
    end
    it 'redirects visitors to the sign-in page' do
      get :index
      expect(response).to redirect_to(signin_path)
    end
  end

  describe '#show' do
    it 'redirects visitors to the sign-in page' do
      get :show, id: @project.id
      expect(response).to redirect_to(signin_path)
    end
  end

  describe '#edit' do
    it 'redirects visitors to the sign-in page' do
      get :edit, id: @project
      expect(response).to redirect_to(signin_path)
    end
  end

  describe '#new' do
    it 'redirects visitors to the sign-in page' do
      get :new
      expect(response).to redirect_to(signin_path)
    end
  end

  describe '#create' do
    it 'redirects visitors to the sign-in page' do
      post :create
      expect(response).to redirect_to(signin_path)
    end
  end

  describe '#update' do
    it 'redirects visitors to the sign-in page' do
      put :update, id: @project
      expect(response).to redirect_to(signin_path)
    end
  end

  describe '#destroy' do
    it 'redirects visitors to the sign-in page' do
      delete :destroy, id: @project
      expect(response).to redirect_to(signin_path)
    end
  end
end
