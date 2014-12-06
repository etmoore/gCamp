require 'rails_helper'

describe UsersController do
  before :each do
    @user = create_user
  end

  describe '#index' do
    it 'redirects visitors to the sign-in page' do
      get :index
      expect(response).to redirect_to(signin_path)
    end
  end
  describe '#show' do
    it 'redirects visitors to the sign-in page' do
      get :show, id: @user
      expect(response).to redirect_to(signin_path)
    end
  end
  describe '#new' do
    it 'redirects visitors to the sign-in page' do
      get :new
      expect(response).to redirect_to(signin_path)
    end
  end
  describe '#edit' do
    it 'redirects visitors to the sign-in page' do
      get :edit, id: @user
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
      put :update, id: @user
      expect(response).to redirect_to(signin_path)
    end
  end
  describe '#destroy' do
    it 'redirects visitors to the sign-in page' do
      delete :destroy, id: @user
      expect(response).to redirect_to(signin_path)
    end
  end
end
