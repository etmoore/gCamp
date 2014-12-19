require 'rails_helper'

describe MembershipsController do

  before :each do
    @project = create_project
    @user = create_user

    @admin = create_user admin: true

    @member = create_user
    @membership = create_membership project: @project, user: @member, role: 'member'

    @owner = create_user
    @ownership = create_membership project: @project, user: @owner, role: 'owner'
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
    it 'renders the memberships index for members' do
      session[:user_id] = @member.id
      get :index, project_id: @project
      expect(response).to render_template('index')
    end
    it 'renders the memberships index for owners' do
      session[:user_id] = @owner.id
      get :index, project_id: @project
      expect(response).to render_template('index')
    end
    it 'renders the memberships index for admins' do
      session[:user_id] = @admin.id
      get :index, project_id: @project
      expect(response).to render_template('index')
    end
  end

  describe '#create' do
    it 'redirects visitors to the sign-in page' do
      post :create, project_id: @project
      expect(response).to redirect_to(signin_path)
    end
    it 'renders 404 for non-members' do
      session[:user_id] = @user.id
      post :create, project_id: @project, membership: {role: 'member'}
      expect(response.status).to eq(404)
    end
    it 'renders 404 for members' do
      session[:user_id] = @member.id
      post :create, project_id: @project, membership: {role: 'member'}
      expect(response.status).to eq(404)
    end
    it 'redirects owners to memberships index after successful save' do
      session[:user_id] = @owner.id
      post :create, project_id: @project, membership: {role: 'member', user_id: create_user.id}
      expect(response).to redirect_to(project_memberships_path(@project))
    end
    it 'redirects admins to memberships index after successful save' do
      session[:user_id] = @admin.id
      post :create, project_id: @project, membership: {role: 'member', user_id: create_user.id}
      expect(response).to redirect_to(project_memberships_path(@project))
    end
  end

  describe '#update' do
    it 'redirects visitors to the signin page' do
      put :update, project_id: @project, id: @membership, membership: {role: 'member'}
      expect(response).to redirect_to(signin_path)
    end
    it 'renders 404 for non-members' do
      session[:user_id] = @user.id
      put :update, project_id: @project, id: @membership, membership: {role: 'member'}
      expect(response.status).to eq(404)
    end
    it 'renders 404 for members' do
      session[:user_id] = @member.id
      put :update, project_id: @project, id: @membership, membership: {role: 'member'}
      expect(response.status).to eq(404)
    end
    it 'redirects owners to memberships index after successful save' do
      session[:user_id] = @owner.id
      put :update, project_id: @project, id: @membership, membership: {role: 'member'}
      expect(response).to redirect_to(project_memberships_path(@project))
    end
    it 'redirects admins to memberships index after successful save' do
      session[:user_id] = @admin.id
      put :update, project_id: @project, id: @membership, membership: {role: 'member'}
      expect(response).to redirect_to(project_memberships_path(@project))
    end
  end

  describe '#destroy' do
    it 'redirects visitors to the signin page' do
      delete :destroy, project_id: @project, id: @membership
      expect(response).to redirect_to(signin_path)
    end
    it 'raises AccessDenied for non-members' do
      membership_to_delete = create_membership project: @project
      session[:user_id] = @user.id
      delete :destroy, project_id: @project, id: membership_to_delete
      expect(response.status).to eq(404)
    end
    it 'renders 404 when a member tries to delete another member' do
      membership_to_delete = create_membership project: @project
      session[:user_id] = @member.id
      delete :destroy, project_id: @project, id: membership_to_delete
      expect(response.status).to eq(404)
    end
    it 'redirects members to memberships index after they delete their membership' do
      session[:user_id] = @member.id
      delete :destroy, project_id: @project, id: @membership
      expect(response).to redirect_to(project_memberships_path(@project))
    end
    it 'redirects owners to memberships index after successful deletion' do
      session[:user_id] = @owner.id
      delete :destroy, project_id: @project, id: @membership
      expect(response).to redirect_to(project_memberships_path(@project))
    end
    it 'redirects admins to memberships index after successful deletion' do
      session[:user_id] = @admin.id
      delete :destroy, project_id: @project, id: @membership
      expect(response).to redirect_to(project_memberships_path(@project))
    end
  end
end
