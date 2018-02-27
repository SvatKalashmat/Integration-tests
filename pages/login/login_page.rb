module PageObjects
  class LoginPage < SitePrism::Page

    set_url '{locale}/login'

    element :button_sign_in, 'input[type=submit]'
    element :button_vk, '.mod-vk > span'
    element :button_fb, '.mod-fb > span'
    element :checkbox_remember_me, '.checkbox-label'
    element :link_forgot_password, "a[href$='reset-password/new'] > span"
    element :link_register, "a[href$='register'] > span"
    section :fields, FieldsSection, '.sign-box'
    section :notification, NotificationSection, '.sign-msg-content'
    section :header, HeaderSection, '.header.mod-sign.mod-dark'

  end
end
