module ApplicationHelper
  def app_name
    'Lunch Service'
  end

  def status_tag(status)
    icon_class = status ? 'ok' : 'remove'
    content_tag(:span, nil, class: "glyphicon glyphicon-#{icon_class}")
  end

  def table_tag(&block)
    content_tag(:table, class: 'table table-responsive table-striped') do
      yield block
    end
  end
end
