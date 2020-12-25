module ApplicationHelper
  def flash_class(level)
    puts level
    case level
    when 'notice' then "alert alert-info"
    when 'success' then "alert alert-success"
    when 'error' then "alert alert-danger"
    when 'alert' then "alert alert-danger"
    else "alert alert-info"
    end
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == params[:sort] && params[:direction] == 'asc' ? 'desc' : 'asc'
    link_to title, sort: column, direction: direction, view: 'table'
  end

  def sort_icon(column)
    return if column != params[:sort]

    if params[:direction] == 'asc'
      content_tag(:i, '', class: 'fas fa-sort-up')
    else
      content_tag(:i, '', class: 'fas fa-sort-down')
    end
  end
end
