class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_project

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = order_and_paginate_tasks.where(complete: false)
    @tasks = order_and_paginate_tasks if show_completed?
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = @project.tasks.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = @project.tasks.new(task_params)
    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_task
      @task = @projects.tasks.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
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
end
