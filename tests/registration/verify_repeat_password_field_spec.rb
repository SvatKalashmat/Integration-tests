require 'spec_helper'

I18n.available_locales.each do |locale|
  describe "#{locale.upcase} Verify validations for field Repeat Password." do

    let(:registration_page) {PageObjects::RegistrationPage.new}

    data = Faker::Lorem.characters(10)
    email = Faker::Internet.safe_email


    it "Pre-conditions." do
      I18n.locale = locale
      registration_page.load(locale: locale)
      registration_page.fields.hint_nickname.set (data)
    end

    context "Show error on field Repeat Password, Highlighte field Repeat Password and Password." do
      after(:each) do
        registration_page.button_sign_up.click
        expect(registration_page).to have_text(I18n.t 'ui_tests.registration_page.errors.incorrect_repeat')
        expect(parent_element(registration_page.fields.hint_repeat_password)[:class]).to include(registration_page.notification.field_highlighted)
        expect(parent_element(registration_page.fields.hint_password)[:class]).to include(registration_page.notification.field_highlighted)
      end

      it "Verify errors when field Repeat Password is empty." do
        registration_page.fields.hint_password.set (data)
      end

      it "Verify errors when field Password and Repeat Password different." do
        registration_page.fields.hint_password.set (data)
        registration_page.fields.hint_repeat_password.set (data.at(0..-2))
      end
    end

    context "Dont show any errors when data in field Repeat Password and Password the same." do
      it "Enter correct and the same data for field Repeat Password and Password." do
        registration_page.fields.hint_password.set (data)
        registration_page.fields.hint_repeat_password.set (data)
        registration_page.button_sign_up.click
        expect(registration_page).not_to have_text(I18n.t 'ui_tests.registration_page.errors.incorrect_repeat')
        expect(parent_element(registration_page.fields.hint_repeat_password)[:class]).not_to include(registration_page.notification.field_highlighted)
        expect(parent_element(registration_page.fields.hint_password)[:class]).not_to include(registration_page.notification.field_highlighted)
      end
    end
    
  end
end
