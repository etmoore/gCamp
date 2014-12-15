require 'rails_helper'

describe MembershipsController do

  before :each do
    @project = create_project
    @membership = create_membership project: @project
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

  describe '#create' do
    it 'redirects visitors to the sign-in page' do
      post :create, project_id: @project
      expect(response).to redirect_to(signin_path)
    end
  end

  describe '#update' do
    it 'redirects visitors to the signin page' do
      put :update, project_id: @project, id: @membership
      expect(response).to redirect_to(signin_path)
    end
  end

  describe '#destroy' do
    it 'redirects visitors to the signin page' do
      delete :destroy, project_id: @project, id: @membership
      expect(response).to redirect_to(signin_path)
    end
    it 'raises AccessDenied when a non-owner tries to delete a member'
    it 'deletes membership and redirects to memberships index when owner clicks delete'
  end
end
