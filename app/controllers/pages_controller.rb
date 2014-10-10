class PagesController < ApplicationController

  def index
    render :index
    columns
  end

  def columns
    @columns = [
      {
        title: 'Tasks',
        content: [
          "Grouped by projects and lists. Just the way you like'em"
        ]
      },
      {
        title: 'Documents',
        content: [
          'Upload',
          'Comment',
          'Revise'
        ]
      },
      {
        title: 'Comments',
        content: [
          'Comment on tasks and documents',
          'Get email notifications'
        ]
      }
    ]
  end
end
