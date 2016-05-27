module ApplicationHelper

  def form_group_tag(errors, &block)
    css_class = 'form-group'
    css_class << ' has-error' if errors.any?
    content_tag :div, capture(&block), class: css_class
  end


  def display_errors(heading, errors_list)
    h4 = content_tag :h4, heading
    errors_list = content_tag :ul do
      errors_list.each { |list_item| concat content_tag :li, list_item}.join
    end
    content_tag :div, h4.concat(errors_list), class: 'alert alert-danger'
  end

  def display_errors_v2(heading, errors_list)
    output = "<div class= 'alert alert-danger'>"
    output += "<h4>#{heading}</h4>"
    output += "<ul>"
    errors_list.each { |list_item| output+= "<li>#{list_item}</li>" }
    output += "</ul>"
    output += "</div>"
    output.html_safe #html_safe returns as HTML rather than plain text
  end

end
