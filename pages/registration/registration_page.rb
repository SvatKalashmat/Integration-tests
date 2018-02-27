module PageObjects
  class RegistrationPage < SitePrism::Page

    set_url '{locale}/register'

    element :button_vk, '.mod-vk > span'
    element :button_fb, '.mod-fb > span'
    element :button_sign_up, 'input[type=submit]'
    section :notification, NotificationSection, '.sign-box'
    section :fields, FieldsSection, '.sign-box'

    def register_by(email, nick, password)
      fields.hint_nickname.set(nick)
      fields.hint_email.set(email)
      fields.hint_password.set(password)
      fields.hint_repeat_password.set(password)
      button_sign_up.click
    end
    
  end
end
