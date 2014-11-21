class MembershipsController < ApplicationController
  before_action :set_project
  def index
    @memberships = @project.memberships
  end

  private

    def set_project
      @project = Project.find(params[:project_id])
    end
end
