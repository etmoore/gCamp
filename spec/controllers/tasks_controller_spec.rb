require 'rails_helper'

describe TasksController do
  before :each do
    @project = create_project
    @task = create_task project: @project
  end

  describe '#index' do
    it 'redirects visitors to the sign-in page' do
      get :index, project_id: @project
      expect(response).to redirect_to(signin_path)
    end
  end
  describe '#show' do
    it 'redirects visitors to the sign-in page' do
      get :show, project_id: @project, id: @task
      expect(response).to redirect_to(signin_path)
    end
  end
  describe '#new' do
    it 'redirects visitors to the sign-in page' do
      get :new, project_id: @project
      expect(response).to redirect_to(signin_path)
    end
  end
  describe '#edit' do
    it 'redirects visitors to the sign-in page' do
      get :edit, project_id: @project, id: @task
      expect(response).to redirect_to(signin_path)
    end
  end
  describe '#create' do
    it 'redirects visitors to the sign-in page' do
      post :create, project_id: @project
      expect(response).to redirect_to(signin_path)
    end
  end
  describe '#update' do
    it 'redirects visitors to the sign-in page' do
      put :update, project_id: @project, id: @task
      expect(response).to redirect_to(signin_path)
    end
  end
  describe '#destroy' do
    it 'redirects visitors to the sign-in page' do
      delete :destroy, project_id: @project, id: @task
      expect(response).to redirect_to(signin_path)
    end
  end
end
