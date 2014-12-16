require 'rails_helper'

describe ProjectsController do

  before [:show, :edit, :update, :destroy] do
    @project = create_project
    @user = create_user

    @member = create_user
    create_membership project: @project, user: @member, role: 'member'

    @owner = create_user
    create_membership project: @project, user: @owner, role: 'owner'
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
    it 'renders 404 for non-owner members' do
      session[:user_id] = @member.id
      get :edit, id: @project
      expect(response.status).to eq(404)
    end
    it 'renders the edit view for owners' do
      session[:user_id] = @owner.id
      get :edit, id: @project
      expect(response).to be_success
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
    it 'makes the creator of the project the owner' do
      session[:user_id] = @user.id
      project_params = {project: {name: 'test project'}}
      post :create, project_params
      expect(Membership.last.role).to eq('owner')
    end
    it 'redirects to the tasks index after a user creates a project' do
      session[:user_id] = @user.id
      project_params = {project: {name: 'test project'}}
      post :create, project_params
      expect(response).to redirect_to project_tasks_path(Project.last)
    end
  end

  describe '#update' do
    it 'redirects visitors to the sign-in page' do
      put :update, id: @project
      expect(response).to redirect_to(signin_path)
    end
    it 'renders 404 for non-owner members' do
      session[:user_id] = @member.id
      put :update, id: @project, project: {name: 'test'}
      expect(response.status).to eq(404)
    end
    it 'redirects to the product show page for owners' do
      session[:user_id] = @owner.id
      put :update, id: @project, project: {name: 'test'}
      expect(response).to redirect_to(@project)
    end
  end

  describe '#destroy' do
    it 'redirects visitors to the sign-in page' do
      delete :destroy, id: @project
      expect(response).to redirect_to(signin_path)
    end
    it 'raises AccessDenied when a non-owner tries to delete a project' do
      user = create_user
      non_owner = create_membership project: @project, user: user, role: 'member'
      session[:user_id] = user.id
      delete :destroy, id: @project
      expect(response.status).to eq(404)
    end
    it 'allows owners to delete projects - redirects to projects index' do
      user = create_user
      owner = create_membership project: @project, user: user, role: 'owner'
      session[:user_id] = user.id
      delete :destroy, id: @project
      expect(response).to redirect_to(projects_path)
    end
  end
end
