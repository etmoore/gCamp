require 'rails_helper'

describe TasksController do
  before :each do
    @project = create_project
    @task = create_task project: @project
    @user = create_user
  end

  describe '#index' do
    it 'redirects visitors to the sign-in page' do
      get :index, project_id: @project
      expect(response).to redirect_to(signin_path)
    end
    it 'renders 404 for non-members' do
      session[:user_id] = @user.id
      get :index, project_id: @project
      expect(response.status).to eq(404)
    end
  end
  describe '#show' do
    it 'redirects visitors to the sign-in page' do
      get :show, project_id: @project, id: @task
      expect(response).to redirect_to(signin_path)
    end
    it 'renders 404 for non-members' do
      session[:user_id] = @user.id
      get :index, project_id: @project
      expect(response.status).to eq(404)
    end
  end
  describe '#new' do
    it 'redirects visitors to the sign-in page' do
      get :new, project_id: @project
      expect(response).to redirect_to(signin_path)
    end
    it 'renders 404 for non-members' do
      session[:user_id] = @user.id
      get :new, project_id: @project
      expect(response.status).to eq(404)
    end
  end
  describe '#edit' do
    it 'redirects visitors to the sign-in page' do
      get :edit, project_id: @project, id: @task
      expect(response).to redirect_to(signin_path)
    end
    it 'renders 404 for non-members' do
      session[:user_id] = @user.id
      get :edit, project_id: @project, id: @task
      expect(response.status).to eq(404)
    end
  end
  describe '#create' do
    it 'redirects visitors to the sign-in page' do
      post :create, project_id: @project
      expect(response).to redirect_to(signin_path)
    end
    it 'renders 404 for non-members' do
      session[:user_id] = @user.id
      post :create, project_id: @project
      expect(response.status).to eq(404)
    end
  end
  describe '#update' do
    it 'redirects visitors to the sign-in page' do
      put :update, project_id: @project, id: @task
      expect(response).to redirect_to(signin_path)
    end
    it 'renders 404 for non-members' do
      session[:user_id] = @user.id
      put :update, project_id: @project, id: @task
      expect(response.status).to eq(404)
    end
  end
  describe '#destroy' do
    it 'redirects visitors to the sign-in page' do
      delete :destroy, project_id: @project, id: @task
      expect(response).to redirect_to(signin_path)
    end
    it 'renders 404 for non-members' do
      session[:user_id] = @user.id
      delete :destroy, project_id: @project, id: @task
      expect(response.status).to eq(404)
    end
  end
end
