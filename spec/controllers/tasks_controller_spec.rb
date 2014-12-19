require 'rails_helper'

describe TasksController do
  before :each do
    @project = create_project
    @task = create_task project: @project
    @user = create_user
    @member = create_user
    create_membership project: @project, user: @member, role: 'member'
    @owner = create_user
    create_membership project: @project, user: @owner, role: 'owner'
    @admin = create_user admin: true
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
    it 'renders the index view for members' do
      session[:user_id] = @member.id
      get :index, project_id: @project
      expect(response).to render_template('index')
    end
    it 'renders the index view for owners' do
      session[:user_id] = @owner.id
      get :index, project_id: @project
      expect(response).to render_template('index')
    end
    it 'renders the index view for admin' do
      session[:user_id] = @admin.id
      get :index, project_id: @project
      expect(response).to render_template('index')
    end
  end

  describe '#show' do
    it 'redirects visitors to the sign-in page' do
      get :show, project_id: @project, id: @task
      expect(response).to redirect_to(signin_path)
    end
    it 'renders 404 for non-members' do
      session[:user_id] = @user.id
      get :show, project_id: @project, id: @task
      expect(response.status).to eq(404)
    end
    it 'renders the show view for members' do
      session[:user_id] = @member.id
      get :show, project_id: @project, id: @task
      expect(response).to render_template('show')
    end
    it 'renders the show view for owners' do
      session[:user_id] = @owner.id
      get :show, project_id: @project, id: @task
      expect(response).to render_template('show')
    end
    it 'renders the show view for admin' do
      session[:user_id] = @admin.id
      get :show, project_id: @project, id: @task
      expect(response).to render_template('show')
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
    it 'renders the new view for members' do
      session[:user_id] = @member.id
      get :new, project_id: @project
      expect(response).to render_template('new')
    end
    it 'renders the new view for owners' do
      session[:user_id] = @owner.id
      get :new, project_id: @project
      expect(response).to render_template('new')
    end
    it 'renders the new view for admin' do
      session[:user_id] = @admin.id
      get :new, project_id: @project
      expect(response).to render_template('new')
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
    it 'renders the edit view for members' do
      session[:user_id] = @member.id
      get :edit, project_id: @project, id: @task
      expect(response).to render_template('edit')
    end
    it 'renders the edit view for owners' do
      session[:user_id] = @owner.id
      get :edit, project_id: @project, id: @task
      expect(response).to render_template('edit')
    end
    it 'renders the edit view for admin' do
      session[:user_id] = @admin.id
      get :edit, project_id: @project, id: @task
      expect(response).to render_template('edit')
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
    it 'redirects members to the task show page after creation' do
      session[:user_id] = @member.id
      post :create, project_id: @project, task: {description: 'test'}
      expect(response).to redirect_to project_task_path(@project, @project.tasks.last)
    end
    it 'redirects owners to the task show page after creation' do
      session[:user_id] = @owner.id
      post :create, project_id: @project, task: {description: 'test'}
      expect(response).to redirect_to project_task_path(@project, @project.tasks.last)
    end
    it 'redirects admin to the task show page after creation' do
      session[:user_id] = @admin.id
      post :create, project_id: @project, task: {description: 'test'}
      expect(response).to redirect_to project_task_path(@project, @project.tasks.last)
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
    it 'redirects members to the task show page after update' do
      session[:user_id] = @member.id
      put :update, project_id: @project, id: @task, task: {description: 'test'}
      expect(response).to redirect_to project_task_path(@project, @project.tasks.last)
    end
    it 'redirects owners to the task show page after update' do
      session[:user_id] = @owner.id
      put :update, project_id: @project, id: @task, task: {description: 'test'}
      expect(response).to redirect_to project_task_path(@project, @project.tasks.last)
    end
    it 'redirects admin to the task show page after update' do
      session[:user_id] = @admin.id
      put :update, project_id: @project, id: @task, task: {description: 'test'}
      expect(response).to redirect_to project_task_path(@project, @project.tasks.last)
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
    it 'redirects members to the tasks index page after deletion' do
      session[:user_id] = @member.id
      delete :destroy, project_id: @project, id: @task
      expect(response).to redirect_to project_tasks_path(@project)
    end
    it 'redirects owners to the tasks index page after deletion' do
      session[:user_id] = @owner.id
      delete :destroy, project_id: @project, id: @task
      expect(response).to redirect_to project_tasks_path(@project)
    end
    it 'redirects admin to the tasks index page after deletion' do
      session[:user_id] = @admin.id
      delete :destroy, project_id: @project, id: @task
      expect(response).to redirect_to project_tasks_path(@project)
    end
  end
end
