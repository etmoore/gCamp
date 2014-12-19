class MembershipsController < ApplicationController
  before_action :set_project
  before_action :members_only, only: [:index]

  def index
    @membership = Membership.new
    @memberships = @project.memberships
    @current_user_owner = current_user_owner?
  end

  def create
    @membership = @project.memberships.new(membership_params)
    raise AccessDenied unless current_user_owner? || current_user.admin?
    if @membership.save
      redirect_to project_memberships_path, notice: "#{@membership.user.full_name} was added successfully"
    else
      render :index
    end
  end

  def update
    @membership = @project.memberships.find(params[:id])
    raise AccessDenied unless current_user_owner? || current_user.admin?
    if @membership.update(membership_params)
      redirect_to project_memberships_path, notice: "#{@membership.user.full_name} was updated successfully"
    else
      render :index
    end
  end

  def destroy
    @membership = @project.memberships.find(params[:id])
    if current_user_owner? || current_user.admin? || @membership.user.id == current_user.id
      @membership.destroy
      redirect_to project_memberships_path, notice: "#{@membership.user.full_name} was removed successfully"
    else
      raise AccessDenied
    end
  end

  private

    def set_project
      @project = Project.find(params[:project_id])
    end

    def current_user_owner?
      @project.memberships.find_by(user_id: current_user.id, role: 'owner') || current_user.admin?
    end
    helper_method :current_user_owner?

    def membership_params
      params.require(:membership).permit(:role, :user_id)
    end

    def members_only
      unless @project.memberships.pluck(:user_id).include?(current_user.id) || current_user.admin?
        raise AccessDenied
      end
    end
end
