module ApplicationHelper

  def page_header(title)
    content_for(:title, title)
    html = '<div class="page-header">'.html_safe
    if block_given?
      html += '<div class="pull-right">'.html_safe
      html += capture { yield }
      html += '</div>'.html_safe
    end
    html += '<h1>'.html_safe
    html += title
    html += '</h1>'.html_safe
    html += '</div>'.html_safe
    html
  end

  def belongs_to_same_project?(user)
    current_user.projects.each do |project|
      return true if project.users.find_by(id: user.id)
    end
    false
  end

  def join_labels(story)
    label_array = story[:labels].map do |label|
      label[:name]
    end
    label_array.join(', ')
  end

end
