class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    if current_user.admin?
      @projects = Project.all
    else
      @projects = current_user.projects
    end
    if current_user.tracker_token && !current_user.tracker_token.lstrip.empty?
      @tracker_projects = API.new.pivotal_projects(current_user)
    end
  end

  def show
    @current_user_owner = current_user_owner?
    raise AccessDenied unless @project.users.include?(current_user) || current_user.admin?
  end

  def edit
    raise AccessDenied unless current_user_owner?
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      @project.memberships.create!(user: current_user, role: 'owner')
      redirect_to project_tasks_path(@project), notice: "Project successfully created."
    else
      render :new
    end
  end

  def update
    raise AccessDenied unless current_user_owner?
    if @project.update(project_params)
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if current_user_owner?
      @project.destroy
      redirect_to projects_path, notice: 'Project was successfully deleted.'
    else
      raise AccessDenied
    end
  end

  private

    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name)
    end

    def current_user_owner?
      @project.memberships.find_by(user_id: current_user.id, role: 'owner') || current_user.admin?
    end
end
