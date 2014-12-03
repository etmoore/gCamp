class CommentsController < ApplicationController
  before_action do
    @task = Task.find(params[:comment][:task_id])
  end

  def create
    @comment = Comment.new(params.require(:comment).permit(:comment, :task_id))
    @comment.user_id = current_user.id
    @comment.save
    redirect_to project_task_path(@task.project, @task)
  end
end
