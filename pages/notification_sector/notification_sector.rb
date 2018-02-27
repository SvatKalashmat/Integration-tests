module PageObjects
  class NotificationSection < SitePrism::Section

    element :sign_ico, '.sign-msg-ico'
    element :timer, '#time'
    element :back_to_site, '#link-back-to-site'

    def field_highlighted
      'is-error'
    end

  end
end
