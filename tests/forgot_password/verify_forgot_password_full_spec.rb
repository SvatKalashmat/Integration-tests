require 'spec_helper'

I18n.available_locales.each do |locale|
  describe "#{locale.upcase} Verify full cycle forgot password." do

    let(:forgot_password_page) {PageObjects::ForgotPasswordPage.new}
    let(:mail_page) {PageObjects::MailPage.new}

    password = Faker::Internet.password(8)
    email = Faker::Internet.safe_email
    nick = Faker::Lorem.characters(6)

    it "Pre-conditions." do
      delete_user_if_available(email)
      I18n.locale = locale
      forgot_password_page.load(locale: locale)
      User.create(email: email, password: password, nick: nick, confirmed_at: Time.now.utc)
      mail_page.clear_mails
    end

    context "Negative tests for Email Field." do
      it "Verfiy error for field Email - field is empty." do
        forgot_password_page.button_restore.click
        expect(forgot_password_page).to have_text(I18n.t "ui_tests.forgot_password_page.errors.email_is_not_valid")
        expect(parent_element(forgot_password_page.fields.hint_email)[:class]).to include(forgot_password_page.notification.field_highlighted)
      end

      it "Verify error for field Email - is not registred." do
        forgot_password_page.fields.hint_email.set(nick)
        forgot_password_page.button_restore.click
        expect(forgot_password_page).to have_text(I18n.t "ui_tests.forgot_password_page.errors.not_registred")
        expect(parent_element(forgot_password_page.fields.hint_email)[:class]).to include(forgot_password_page.notification.field_highlighted)
      end
    end

    context "Positive tests." do
      it "Enter correct email." do
        forgot_password_page.fields.hint_email.set(email)
        forgot_password_page.button_restore.click
      end

      it "Verify message - mail sended." do
        expect(forgot_password_page).to have_text(I18n.t "ui_tests.notification.forgot_mail_sended")
      end

      it "Waiting for the letter to come." do
        wait(10.seconds).for { mail_page.mailbox.count }.to eq(1)
      end

      it "Verify subject in mail |#{I18n.t 'ui_tests.mail.subject'}|" do
        expect(mail_page.mailbox.messages.last.subject).to include(I18n.t 'ui_tests.forgot_password_page.mail.subject')
      end

      it "Verify greeting with a email: |#{email}|." do
        expect(mail_page.mail_text).to include(I18n.t 'ui_tests.forgot_password_page.mail.email', email: email)
      end

      it "Verify body mail." do
        expect(mail_page.mail_text).to include(I18n.t 'ui_tests.forgot_password_page.mail.body')
      end

      it "Verify link confirmation." do
        expect(mail_page.mail_text).to include(I18n.t 'ui_tests.forgot_password_page.mail.edit_link')
      end

      it "Verify text about ignore message." do
        expect(mail_page.mail_text).to include(I18n.t 'ui_tests.forgot_password_page.mail.ignor')
      end

      it "Get link Forgot Password and click." do
        mail_page.get_link_and_click
      end

      it "Verify layout |#{I18n.t 'ui_tests.forgot_password_page.label_restore'}|." do
        expect(forgot_password_page).to have_text(I18n.t 'ui_tests.forgot_password_page.label_restore')
      end

      it "Verify layout |#{I18n.t 'ui_tests.forgot_password_page.label_new_password'}|." do
        expect(forgot_password_page).to have_text(I18n.t 'ui_tests.forgot_password_page.label_new_password')
      end
    end

    context "Negative tests for fields Password and Repeat password." do
      after(:each) do
        expect(parent_element(forgot_password_page.fields.hint_password)[:class]).to include(forgot_password_page.notification.field_highlighted)
      end

      it "Verify show errors when fields Password and Repeat_password - is empty." do
        forgot_password_page.button_restore.click
        expect(forgot_password_page).to have_text(I18n.t "ui_tests.registration_page.errors.length_password")
      end

      it "Verify show error when entered data in field Password and Repeat_password - different." do
        forgot_password_page.fields.hint_password.set(nick)
        forgot_password_page.fields.hint_repeat_password.set(password)
        forgot_password_page.button_restore.click
        expect(forgot_password_page).to have_text(I18n.t "ui_tests.registration_page.errors.incorrect_repeat")
      end
    end

    context "Positive tests for fields Password and Repeat password." do
      it "Enter correct data for field Password and Repeat_password." do
        forgot_password_page.fields.hint_password.set(password)
        forgot_password_page.fields.hint_repeat_password.set(password)
        forgot_password_page.button_restore.click
      end

      it "Verfiy layout |#{I18n.t "ui_tests.notification.successfully_changed"}|." do
        expect(forgot_password_page).to have_text(I18n.t "ui_tests.notification.successfully_changed")
      end
    end
    
  end
end
