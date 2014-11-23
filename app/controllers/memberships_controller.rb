class MembershipsController < ApplicationController
  before_action :set_project

  def index
    @membership = Membership.new
    @memberships = @project.memberships
  end

  def create
    membership = @project.memberships.new(membership_params)
    if membership.save
      redirect_to project_memberships_path, notice: "#{membership.user.full_name} was added successfully"
    else
      render :index
    end
  end

  def update
    membership = @project.memberships.find(params[:id])
    if membership.update(membership_params)
      redirect_to project_memberships_path, notice: "#{membership.user.full_name} was updated successfully"
    else
      render :index
    end
  end

  def destroy
    membership = @project.memberships.find(params[:id])
    membership.destroy
    redirect_to project_memberships_path, notice: "#{membership.user.full_name} was destroyed successfully"
  end

  private

    def set_project
      @project = Project.find(params[:project_id])
    end

    def membership_params
      params.require(:membership).permit(:role, :user_id)
    end
end
