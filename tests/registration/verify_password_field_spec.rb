require 'spec_helper'

I18n.available_locales.each do |locale|
  describe "#{locale.upcase} Verify validations field Password." do
    
    let(:registration_page) {PageObjects::RegistrationPage.new}

    it "Pre-conditions." do
      I18n.locale = locale
      registration_page.load(locale: locale)
    end

    context "Negative tests." do
      after(:each) do
        registration_page.button_sign_up.click
        expect(registration_page).to have_text(I18n.t "ui_tests.registration_page.errors.length_password")
        expect(parent_element(registration_page.fields.hint_password)[:class]).to include(registration_page.notification.field_highlighted)
      end

      it "Verify error |#{I18n.t 'ui_tests.registration_page.errors.length_password'}| when field Password is empty." do
        password = Faker::Number.number(10)
        registration_page.fields.hint_repeat_password.set (password)
      end

      it "Verify error |#{I18n.t 'ui_tests.registration_page.errors.length_password'}| when field Password have 5 characters." do
        password = Faker::Number.number(5)
        registration_page.fields.hint_password.set (password)
        registration_page.fields.hint_repeat_password.set (password)
      end

      it "Verify error |#{I18n.t 'ui_tests.registration_page.errors.length_password'}| when field Password have 33 characters." do
        password = Faker::Number.number(33)
        registration_page.fields.hint_password.set (password)
        registration_page.fields.hint_repeat_password.set (password)
      end
    end

    it "Verify error |#{I18n.t 'ui_tests.registration_page.errors.symbol_password'}| when field Password have incorrect symbols." do
      password = Faker::Number.number(5) + "@\\АбВг:"
      registration_page.fields.hint_password.set (password)
      registration_page.fields.hint_repeat_password.set (password)
      registration_page.button_sign_up.click
      expect(registration_page).to have_text(I18n.t "ui_tests.registration_page.errors.symbol_password")
      expect(parent_element(registration_page.fields.hint_password)[:class]).to include(registration_page.notification.field_highlighted)
    end

    context "Positive tests, correct symbols and numbers." do
      after(:each) do
        registration_page.button_sign_up.click
        expect(registration_page).not_to have_text(I18n.t "ui_tests.registration_page.errors.symbol_password")
        expect(parent_element(registration_page.fields.hint_password)[:class]).not_to include(registration_page.notification.field_highlighted)
      end

      it "Verify error |#{I18n.t 'ui_tests.registration_page.errors.symbol_password'}| when field Password have correct symbols." do
        password = "!#$%&'*+-/=?^_`{|}~"
        registration_page.fields.hint_password.set (password)
        registration_page.fields.hint_repeat_password.set(password) # для условия "при  несовпадении, как некорректные выделяются оба поля ввода - пароль и его повтор"
      end

      it "Verify error |#{I18n.t 'ui_tests.registration_page.errors.symbol_password'}| when field Password have only numbers." do
        password = Faker::Internet.password(10)
        registration_page.fields.hint_password.set (password)
        registration_page.fields.hint_repeat_password.set(password) # для условия "при  несовпадении, как некорректные выделяются оба поля ввода - пароль и его повтор"
      end
    end

  end
end
