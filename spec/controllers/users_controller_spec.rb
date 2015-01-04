require 'rails_helper'

describe UsersController do
  before :each do
    @user = create_user
    @other_user = create_user
    @admin = create_user admin: true

    @user_params = {first_name: "Test",
                    last_name: "Dummy",
                    email: 'test@example.com',
                    password: 'password',
                    password_confirmation: 'password'}
  end

  describe '#index' do
    it 'redirects visitors to the sign-in page' do
      get :index
      expect(response).to redirect_to(signin_path)
    end
    it 'renders the index view for admin' do
      session[:user_id] = @admin.id
      get :index
      expect(response).to render_template('index')
    end
  end

  describe '#show' do
    it 'redirects visitors to the sign-in page' do
      get :show, id: @user
      expect(response).to redirect_to(signin_path)
    end
    it 'renders the show view for admin' do
      session[:user_id] = @admin.id
      get :show, id: @user
      expect(response).to render_template('show')
    end
  end

  describe '#new' do
    it 'redirects visitors to the sign-in page' do
      get :new
      expect(response).to redirect_to(signin_path)
    end
    it 'renders the new view for admin' do
      session[:user_id] = @admin.id
      get :new
      expect(response).to render_template('new')
    end
  end

  describe '#edit' do
    it 'redirects visitors to the sign-in page' do
      get :edit, id: @user
      expect(response).to redirect_to(signin_path)
    end
    it 'renders 404 when a user tries to edit another user' do
      session[:user_id] = @user.id
      get :edit, id: @other_user
      expect(response.status).to eq(404)
    end
    it 'renders the current user\'s edit page' do
      session[:user_id] = @user.id
      get :edit, id: @user
      expect(response).to render_template('edit')
    end
    it 'renders the edit view for admin' do
      session[:user_id] = @admin.id
      get :edit, id: @user
      expect(response).to render_template('edit')
    end
  end

  describe '#create' do
    it 'redirects visitors to the sign-in page' do
      post :create
      expect(response).to redirect_to(signin_path)
    end
    it 'creates a new user then redirects to index for admin' do
      session[:user_id] = @admin.id
      post :create, user: @user_params
      expect(User.last[:first_name]).to eq("Test")
      expect(response).to redirect_to users_path
    end
  end

  describe '#update' do
    it 'redirects visitors to the sign-in page' do
      put :update, id: @user
      expect(response).to redirect_to(signin_path)
    end
    it 'updates a user then redirects to index for admin' do
      session[:user_id] = @admin.id
      put :update, id: @user, user: @user_params
      expect(User.find(@user.id)[:first_name]).to eq("Test")
      expect(response).to redirect_to users_path
    end
  end

  describe '#destroy' do
    it 'redirects visitors to the sign-in page' do
      delete :destroy, id: @user
      expect(response).to redirect_to(signin_path)
    end
    it 'destroys a user then redirects to index for admin' do
      session[:user_id] = @admin.id
      delete :destroy, id: @other_user
      expect(User.find_by(id: @other_user.id)).to eq(nil)
      expect(response).to redirect_to users_path
    end
    it 'renders 404 when a user tries to delete another user' do
      session[:user_id] = @user.id
      delete :destroy, id: @other_user
      expect(response.status).to eq(404)
    end
    it 'allows current user to destroy self then redirects to users index' do
      session[:user_id] = @user.id
      delete :destroy, id: @user
      expect(User.find_by(id: @user.id)).to eq(nil)
      expect(response).to redirect_to users_path
    end
  end
end
