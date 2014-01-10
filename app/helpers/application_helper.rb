module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "My Test Blog"
    return base_title if page_title.empty?
    return "#{base_title} | #{page_title}"
  end
end