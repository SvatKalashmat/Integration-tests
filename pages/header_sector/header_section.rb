module PageObjects
  class HeaderSection < SitePrism::Section

    element :example_logo, '#Layer_1'
    element :login_button, '.item-link[href$="/login"]'
    element :registration_button, '.item-link[href$="/register"]'
    element :change_account_button, '.item-link[href$="/logout"]'

  end
end
