class PagesController < ApplicationController

  def homepage
    @columns = {Tasks:['Grouped by projects and lists, just the way you like\'em'],
                Documents:['Upload','Comment','Revise'],
                Comments:['Comment on task and documents','Get email notifications']
                }
    render :homepage
  end

  def about
    render :about
  end

  def terms
    render :terms
  end

end
