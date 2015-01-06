class TrackerProjectsController < ApplicationController
  def show
    @stories = API.new.pivotal_stories(current_user, params[:id])
    @project = API.new.pivotal_project(current_user, params[:id])
  end
end
