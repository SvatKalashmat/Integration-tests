require "spec_helper"

I18n.available_locales.each do |locale|
  describe "#{locale.upcase} All elements show and have translated for Forgot Password Page." do

    let(:forgot_password_page) { PageObjects::ForgotPasswordPage.new }

    it "Pre-conditions." do
      I18n.locale = locale
      forgot_password_page.load(locale: locale)
    end

    it "Should show text |#{I18n.t 'ui_tests.forgot_password_page.label_restore'}|." do
      expect(forgot_password_page).to have_text(I18n.t 'ui_tests.forgot_password_page.label_restore')
    end

    it "Should show text |#{I18n.t 'ui_tests.forgot_password_page.label_enter_email'}|." do
      expect(forgot_password_page).to have_text(I18n.t 'ui_tests.forgot_password_page.label_enter_email')
    end

    it "Should show Email field with placeholder |#{I18n.t 'ui_tests.forgot_password_page.hint_email'}|." do
      expect(forgot_password_page).to have_field(forgot_password_page.hint_email[:id], placeholder: (I18n.t 'ui_tests.registration_page.hint_email'))
    end

    it "Should show button Restore password |#{I18n.t 'ui_tests.forgot_password_page.button_restore'}|." do
      expect(forgot_password_page.button_restore[:value]).to eq(I18n.t 'ui_tests.forgot_password_page.button_restore')
    end
    
  end
end
