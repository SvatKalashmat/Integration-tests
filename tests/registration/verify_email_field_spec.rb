require 'spec_helper'

I18n.available_locales.each do |locale|
  describe "#{locale.upcase} Verify field Email." do

    let(:registration_page) {PageObjects::RegistrationPage.new}

    password = Faker::Internet.password(8)
    email = Faker::Internet.safe_email
    nick = Faker::Lorem.characters(6)

    valid_emails = [
      "a@aa.c",
      "alex@yandex.ru",
      "alex-27@yandex.com",
      "alex.27@yandex.com",
      "alex111@devcolibri.com",
      "alex.100@devcolibri.com.ua",
      "alex@1.com",
      "alex@gmail.com.com",
      "alex+27@gmail.com",
      "alex-27@yandex-test.com"
    ]

    invalid_emails = [
      "a",
      "NotAnEmail",
      "@NotAnEmail",
      "alex@.com.ua",
      "alex123@.com",
      "alex123@.com.com",
      ".alex@devcolibri.com",
      "alex()*@gmail.com",
      "alex@%*.com",
      "alex..2013@gmail.com",
      "alex.@gmail.com",
      "alex@devcolibri@gmail.com",
      "фывфвы@asd.сом",
      "al ex@com.com",
      "a"*254,
    ]

    it "Pre-conditions." do
      I18n.locale = locale
      registration_page.load(locale: locale)
    end

    it "Verfiy error if email aready used." do
      delete_user_if_available(email)
      User.create(email: email, password: password, nick: nick)
      registration_page.fields.hint_email.set(email)
      registration_page.button_sign_up.click
      expect(registration_page).to have_text(I18n.t "ui_tests.registration_page.errors.email_already_use")
      expect(parent_element(registration_page.fields.hint_email)[:class]).to include(registration_page.notification.field_highlighted)
    end

    it "clear fiels" do
      registration_page.fields.hint_email.set(:clear)
    end

    context "Negative tests." do
      after(:each) do
        registration_page.button_sign_up.click
        expect(registration_page).to have_text(I18n.t "ui_tests.registration_page.errors.email_is_not_valid")
        expect(parent_element(registration_page.fields.hint_email)[:class]).to include(registration_page.notification.field_highlighted)
      end

      it "Verify error when Email is empty." do
      end

      invalid_emails.each do |email|
        it "Enter invalid emails |#{email}|." do
          registration_page.fields.hint_email.set(email)
        end
      end
    end

    context "Positive tests." do
      after(:each) do
        registration_page.button_sign_up.click
        expect(registration_page).not_to have_text(I18n.t "ui_tests.registration_page.errors.email_is_not_valid")
        expect(parent_element(registration_page.fields.hint_email)[:class]).not_to include(registration_page.notification.field_highlighted)
      end

      valid_emails.each do |email|
        it "Enter valid emails |#{email}|." do
          registration_page.fields.hint_email.set(email)
        end
      end
    end
    
  end
end
