class TasksController < ApplicationController
  before_action :set_project
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :members_only

  def index
    if show_completed?
      order_and_paginate_tasks
    else
      order_and_paginate_tasks.where(complete: false)
    end
  end

  def show
    @comment = Comment.new
    @comments = @task.comments.all
  end

  def new
    @task = @project.tasks.new
  end

  def edit
  end

  def create
    @task = @project.tasks.new(task_params)
    if @task.save
      redirect_to project_task_path(@project, @task), notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to project_task_path(@project, @task), notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to project_tasks_path, notice: 'Task was successfully destroyed.'
  end

  private

    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_task
      @task = @project.tasks.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:description, :complete, :due)
    end

    def show_completed?
      params[:show_completed]
    end

    def sort_column
      @project.tasks.column_names.include?(params[:sort]) ? params[:sort] : "due"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
    end

    def order_and_paginate_tasks
      @project.tasks.order("#{sort_column} #{sort_direction}").page(params[:page])
    end

    def members_only
      unless @project.memberships.pluck(:user_id).include?(current_user.id) || current_user.admin?
        raise AccessDenied
      end
    end
end
