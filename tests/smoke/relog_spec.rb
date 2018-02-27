require 'spec_helper'

I18n.available_locales.each do |locale|
  describe "#{locale.upcase} Verify re-log." do

    let(:login_page) {PageObjects::LoginPage.new}
    let(:example_page) {PageObjects::ExamplePage.new}

    password = Faker::Internet.password(8)
    email = Faker::Internet.safe_email
    nick = Faker::Lorem.characters(6)

    it "Pre-conditions." do
      delete_user_if_available(email)
      User.create(email: email, password: password, nick: nick, confirmed_at: Time.now.utc)
      I18n.locale = locale
      login_page.load(locale: locale)
    end

    it "Login user " do
      login_page.fields.hint_email.set(email)
      login_page.fields.hint_password.set(password)
      login_page.button_sign_in.click
    end

    it "Click Button Back to site" do
      login_page.notification.back_to_site.click
    end

    it "Verify redirect to example.com." do
      expect(Capybara.current_url).to eq(example_page.url + locale.to_s)
    end

    it "Go back" do
      login_page.load(locale: locale)
    end

    it "User should be autorized in oauth" do
      expect(login_page.header.change_account_button.text).to eq(I18n.t 'ui_tests.header.change_account')
    end

    it "Click change_account" do
      login_page.header.change_account_button.click
    end

    it "User should be unautorized in site" do
      expect(login_page.header.login_button.text).to eq(I18n.t 'ui_tests.header.login')
      expect(login_page.header.registration_button.text).to eq(I18n.t 'ui_tests.header.registration')
    end

  end
end
