require 'rails_helper'

describe MembershipsController do

  before :each do
    @project = create_project
    @membership = create_membership project: @project
  end

  describe '#index' do
    it 'redirects visitors to the sign-in page' do
      get :index, project_id: @project
      expect(response).to redirect_to(signin_path)
    end
  end

  describe '#create' do
    it 'redirects visitors to the sign-in page' do
      get :create, project_id: @project
      expect(response).to redirect_to(signin_path)
    end
  end

  describe '#update' do
    it 'redirects visitors to the signin page' do
      get :update, project_id: @project, id: @membership
      expect(response).to redirect_to(signin_path)
    end
  end

  describe '#destroy' do
    it 'redirects visitors to the signin page' do
      delete :destroy, project_id: @project, id: @membership
    end
  end
end
