require 'spec_helper'

I18n.available_locales.each do |locale|
  describe "#{locale.upcase} Verify in mail - link_confirmation and notifications about successfully autorized." do

    let(:registration_page) {PageObjects::RegistrationPage.new}
    let(:mail_page) {PageObjects::MailPage.new}
    let(:expamle_page) {PageObjects::ExamplePage.new}

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

    it "Waiting for the letter to come." do
      wait(10.seconds).for { mail_page.mailbox.count }.to eq(1)
    end

    it "Get link confirmation and click." do
      mail_page.get_link_and_click
    end

    it "Verify green ico - seccesfull." do
      expect(mail_page.notification.has_sign_ico?).to be true
    end

    it "Verify - text should be displayed |#{I18n.t 'ui_tests.notification.successfully authorized'}|." do
      expect(mail_page).to have_text(I18n.t 'ui_tests.notification.successfully authorized')
    end

    it "Verify - text should be displayed |#{I18n.t 'ui_tests.notification.redirect_to_site'}|." do
      expect(mail_page).to have_text(I18n.t 'ui_tests.notification.redirect_to_site')
    end

    it "Verify - timer should be displayed." do
      expect(mail_page.notification.has_timer?).to be true
    end

    it "Verify - text should be displayed |#{I18n.t 'ui_tests.notification.sec'}|." do
      expect(mail_page).to have_text(I18n.t 'ui_tests.notification.sec')
    end

    it "Verify text for link Back to site." do
      expect(mail_page.notification.back_to_site.text).to eq(I18n.t 'ui_tests.notification.back_to_site')
    end

    it "Verify redirect to example.com." do
      sleep 5
      expect(Capybara.current_url).to eq(example_page.url + locale.to_s)
    end

  end
end
