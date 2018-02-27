require 'spec_helper'

I18n.available_locales.each do |locale|
  describe "#{locale.upcase} All elements show and have translated for Login Page." do

    let(:login_page) { PageObjects::LoginPage.new }

    it "Pre-conditions." do
      I18n.locale = locale
     login_page.load(locale: locale)
    end

    it "Should show text |#{I18n.t 'ui_tests.login_page.label_have_account'}|." do
      expect(login_page).to have_text(I18n.t 'ui_tests.login_page.label_have_account')
    end

    it "Should show text |#{I18n.t 'ui_tests.login_page.label_sign_in'}|." do
      expect(login_page).to have_text(I18n.t 'ui_tests.login_page.label_sign_in')
    end

    it "Should show button_vk |#{I18n.t 'ui_tests.login_page.button_vk'}|." do
      expect(login_page.button_vk.text).to eq(I18n.t 'ui_tests.login_page.button_vk')
    end

    it "Should show button_fb |#{I18n.t 'ui_tests.login_page.button_fb'}|." do
      expect(login_page.button_fb.text).to eq(I18n.t 'ui_tests.login_page.button_fb')
    end

    it "Should show text |#{I18n.t 'ui_tests.login_page.label_or'}|." do
      expect(login_page).to have_text(I18n.t 'ui_tests.login_page.label_or')
    end

    it "Should show text |#{I18n.t 'ui_tests.login_page.label_use_email'}|." do
      expect(login_page).to have_text(I18n.t 'ui_tests.login_page.label_use_email')
    end

    it "Should show Email field with placeholder |#{I18n.t 'ui_tests.login_page.hint_email'}|." do
      expect(login_page).to have_field(login_page.fields.hint_email[:id], placeholder: (I18n.t 'ui_tests.login_page.hint_email'))
    end

    it "Should show Password field with placeholder |#{I18n.t 'ui_tests.login_page.hint_password'}|." do
      expect(login_page).to have_field(login_page.fields.hint_password[:id], placeholder: (I18n.t 'ui_tests.login_page.hint_password'))
    end

    it "Should show Remember me Checkbox |#{I18n.t 'ui_tests.login_page.checkbox_remember_me'}|." do
      expect(login_page.checkbox_remember_me.text).to eq(I18n.t 'ui_tests.login_page.checkbox_remember_me')
    end

    it "Should show link Forgot Password |#{I18n.t 'ui_tests.login_page.link_forgot_password'}|." do
      expect(login_page.link_forgot_password.text).to eq(I18n.t 'ui_tests.login_page.link_forgot_password')
    end

    it "Should show text |#{I18n.t 'ui_tests.login_page.label_register'}|." do
      expect(login_page).to have_text(I18n.t 'ui_tests.login_page.label_register')
    end

    it "Should show link Register |#{I18n.t 'ui_tests.login_page.link_register'}|." do
      expect(login_page.link_register.text).to eq(I18n.t 'ui_tests.login_page.link_register')
    end

    it "Should show button_sign_in |#{I18n.t 'ui_tests.login_page.button_sign_in'}|." do
      expect(login_page.button_sign_in[:value]).to eq(I18n.t 'ui_tests.login_page.button_sign_in')
    end

  end
end
