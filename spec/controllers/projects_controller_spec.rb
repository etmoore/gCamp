require 'rails_helper'

describe ProjectsController do

  before [:show, :edit, :update, :destroy] do
    @project = create_project
    @user = create_user
    @admin = create_user admin: true

    @member = create_user
    create_membership project: @project, user: @member, role: 'member'

    @owner = create_user
    create_membership project: @project, user: @owner, role: 'owner'
  end

  describe '#index' do
    it 'redirects visitors to the sign-in page' do
      get :index
      expect(response).to redirect_to(signin_path)
    end
    it 'renders the index template' do
      session[:user_id] = create_user.id
      get :index
      expect(response).to render_template('index')
    end
  end

  describe '#show' do
    it 'redirects visitors to the sign-in page' do
      get :show, id: @project.id
      expect(response).to redirect_to(signin_path)
    end
    it 'renders 404 for non-members' do
      session[:user_id] = @user.id
      get :show, id: @project.id
      expect(response.status).to eq(404)
    end
    it 'renders the project show template for members' do
      session[:user_id] = @member.id
      get :show, id: @project.id
      expect(response).to render_template('show')
    end
    it 'renders the project show template for owners' do
      session[:user_id] = @owner.id
      get :show, id: @project.id
      expect(response).to render_template('show')
    end
    it 'renders the project show template for admins' do
      session[:user_id] = @admin.id
      get :show, id: @project.id
      expect(response).to render_template('show')
    end
  end

  describe '#edit' do
    it 'redirects visitors to the sign-in page' do
      get :edit, id: @project
      expect(response).to redirect_to(signin_path)
    end
    it 'renders 404 for non-members' do
      session[:user_id] = @user.id
      get :edit, id: @project
      expect(response.status).to eq(404)
    end
    it 'renders 404 for members' do
      session[:user_id] = @member.id
      get :edit, id: @project
      expect(response.status).to eq(404)
    end
    it 'renders the edit view for owners' do
      session[:user_id] = @owner.id
      get :edit, id: @project
      expect(response).to render_template('edit')
    end
    it 'renders the edit view for admins' do
      session[:user_id] = @admin.id
      get :edit, id: @project
      expect(response).to render_template('edit')
    end
  end

  describe '#new' do
    it 'redirects visitors to the sign-in page' do
      get :new
      expect(response).to redirect_to(signin_path)
    end
    it 'renders the new view for non-members' do
      session[:user_id] = @user.id
      get :new
      expect(response).to render_template('new')
    end
    it 'renders the new view for members' do
      session[:user_id] = @member.id
      get :new
      expect(response).to render_template('new')
    end
    it 'renders the new view for owners' do
      session[:user_id] = @owner.id
      get :new
      expect(response).to render_template('new')
    end
    it 'renders the new view for admins' do
      session[:user_id] = @admin.id
      get :new
      expect(response).to render_template('new')
    end
  end

  describe '#create' do
    it 'redirects visitors to the sign-in page' do
      post :create
      expect(response).to redirect_to(signin_path)
    end
    it 'makes the project creator the owner' do
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
    it 'redirects to the tasks index after an admin creates a project' do
      session[:user_id] = @admin.id
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
    it 'renders 404 for non-members' do
      session[:user_id] = @user.id
      put :update, id: @project, project: {name: 'test'}
      expect(response.status).to eq(404)
    end
    it 'renders 404 for members' do
      session[:user_id] = @member.id
      put :update, id: @project, project: {name: 'test'}
      expect(response.status).to eq(404)
    end
    it 'redirects owners to the product show page' do
      session[:user_id] = @owner.id
      put :update, id: @project, project: {name: 'test'}
      expect(response).to redirect_to(@project)
    end
    it 'redirects admins to the product show page' do
      session[:user_id] = @admin.id
      put :update, id: @project, project: {name: 'test'}
      expect(response).to redirect_to(@project)
    end
  end

  describe '#destroy' do
    it 'redirects visitors to the sign-in page' do
      delete :destroy, id: @project
      expect(response).to redirect_to(signin_path)
    end
    it 'raises AccessDenied when a non-member tries to delete a project' do
      session[:user_id] = @user.id
      delete :destroy, id: @project
      expect(response.status).to eq(404)
    end
    it 'raises AccessDenied when a member tries to delete a project' do
      session[:user_id] = @member.id
      delete :destroy, id: @project
      expect(response.status).to eq(404)
    end
    it 'allows owners to delete projects - redirects to projects index' do
      session[:user_id] = @owner.id
      delete :destroy, id: @project
      expect(response).to redirect_to(projects_path)
    end
    it 'allows admins to delete projects then redirects to projects index' do
      session[:user_id] = @admin.id
      delete :destroy, id: @project
      expect(response).to redirect_to(projects_path)
    end
  end
end
