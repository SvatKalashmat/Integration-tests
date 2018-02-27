require 'spec_helper'

I18n.available_locales.each do |locale|
  describe "#{locale.upcase} To check the sending of the letter, the text of the letter." do

    let(:registration_page) {PageObjects::RegistrationPage.new}
    let(:mail_page) {PageObjects::MailPage.new}

    data = Faker::Lorem.characters(10)
    email = Faker::Internet.email

    it "Pre-conditions." do
      delete_user_if_available(email)
      mail_page.clear_mails
    end

    it "Load Registration Page." do
      I18n.locale = locale
      registration_page.load(locale: locale)
    end

    it "Fill in all the fields: email:#{email}, nick:#{data}, password:#{data}, Repeat_password:#{data}." do
      registration_page.register_by(email, data, data)
    end

    it "Verify the correctness of the text, if the registration is successful." do
      expect(registration_page).to have_text(I18n.t 'ui_tests.notification.registration_completed')
    end

    it "Waiting for the letter to come." do
      wait(10.seconds).for { mail_page.mailbox.count }.to eq(1)
    end

    it "Verify subject in mail |#{I18n.t 'ui_tests.mail.subject'}|." do
      expect(mail_page.mailbox.messages.last.subject).to include(I18n.t 'ui_tests.mail.subject')
    end

    it "Verify greeting with a nickname: |#{data}|." do
      expect(mail_page.mail_text).to include(I18n.t 'ui_tests.mail.nick', nick: data)
    end

    it "Verify body mail." do
      expect(mail_page.mail_text).to include(I18n.t 'ui_tests.mail.body')
    end

    it "Verify link confirmation." do
      expect(mail_page.mail_text).to include(I18n.t 'ui_tests.mail.link_confirm')
    end
    
  end
end
