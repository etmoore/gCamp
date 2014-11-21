class MembershipsController < ApplicationController
  before_action :set_project
  def index
    @membership = Membership.new
    @memberships = @project.memberships
  end

  def create
    @membership = @project.memberships.new(params.require(:membership).permit(:role, :user_id))
    if @membership.save
      redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} added successfully"
    else
      render :index
    end
  end

  def destroy
    @membership = @project.memberships.find(params[:id])
    @membership.destroy
    redirect_to project_memberships_path, notice: "#{@membership.user.full_name} was destroyed successfully"
  end

  private

    def set_project
      @project = Project.find(params[:project_id])
    end
end
