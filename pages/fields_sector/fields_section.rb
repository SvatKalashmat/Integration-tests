module PageObjects
  class FieldsSection < SitePrism::Section

    element :hint_nickname, '#user_nick'
    element :hint_email,  '#user_email'
    element :hint_password, '#user_password'
    element :hint_repeat_password, '#user_password_confirmation'

  end
end
