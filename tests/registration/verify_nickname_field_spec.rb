require 'spec_helper'

I18n.available_locales.each do |locale|
  describe "#{locale.upcase} Verify validations fields Your Nickname." do

    let(:registration_page) {PageObjects::RegistrationPage.new}

    it "Pre-conditions." do
      I18n.locale = locale
      registration_page.load(locale: locale)
    end

    context "It enter data on Field Nickname." do
      context "Negative tests." do
        after(:each) do
          registration_page.button_sign_up.click
          expect(registration_page).to have_text(I18n.t "ui_tests.registration_page.errors.length_nick")
          expect(parent_element(registration_page.fields.hint_nickname)[:class]).to include(registration_page.notification.field_highlighted)
        end

        it "Verify error |#{I18n.t 'ui_tests.registration_page.errors.length_nick'}| when field Nickname is emty." do
        end

        it "Verify error |#{I18n.t 'ui_tests.registration_page.errors.length_nick'}| when field Nickname have 1 characters." do
          registration_page.fields.hint_nickname.set (Faker::Number.number(1))
        end

        it "Verify error |#{I18n.t 'ui_tests.registration_page.errors.length_nick'}| when field Nickname have 17 characters." do
          registration_page.fields.hint_nickname.set (Faker::Number.number(17))
        end
      end

      context "Positive tests." do
        after(:each) do
          registration_page.button_sign_up.click
          expect(registration_page).not_to have_text(I18n.t "ui_tests.registration_page.errors.length_nick")
          expect(parent_element(registration_page.fields.hint_nickname)[:class]).not_to include(registration_page.notification.field_highlighted)
        end

        it "Verify error |#{I18n.t 'ui_tests.registration_page.errors.length_nick'}| when field Nickname have 2 characters." do
          registration_page.fields.hint_nickname.set (Faker::Number.number(2))
        end

        it "Verify error |#{I18n.t 'ui_tests.registration_page.errors.length_nick'}| when field Nickname have 16 characters." do
          registration_page.fields.hint_nickname.set (Faker::Number.number(16))
        end
      end
    end
    
  end
end
