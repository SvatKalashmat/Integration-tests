module Helpers

  def parent_element(element)
    element.find(:xpath, '..')
  end

  def to_text(html)
    ActionController::Base.helpers.strip_tags(html).gsub(/\s+/,' ')
  end

  def delete_user_if_available(email)
    user = User.find_by(email: email)
    user.delete unless user.nil?
  end
  
end
