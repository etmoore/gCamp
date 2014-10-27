module TasksHelper
  def sortable column, show_complete = false, title = nil
    title ||= column.titleize
    direction = (column == params[:sort] && params[:direction] = "asc") ? "desc" : "asc"
    link_to title, :sort => column, :direction => direction, sort_by: params[:sort_by], show_complete: show_complete
  end
end
