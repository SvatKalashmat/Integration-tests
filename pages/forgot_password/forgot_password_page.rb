module PageObjects
  class ForgotPasswordPage < SitePrism::Page

    set_url '{locale}/reset-password/new'

    element :button_restore, 'input[type=submit]'
    section :notification, NotificationSection, '.sign-box'
    section :fields, FieldsSection, '.sign-box'

  end
end
