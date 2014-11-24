class CommentsController < ApplicationController
  before_action do
    @project = Project.find(params[:comment][:project_id])
    @task = Task.find(params[:comment][:task_id])
  end

  def create
    @comment = Comment.new(params.require(:comment).permit(:comment, :task_id))
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to project_task_path(@project, @task)
    else
      render project_task_path
    end
  end
end
