require 'spec_helper'

I18n.available_locales.each do |locale|
  describe "#{locale.upcase} All elements show and have translated for Registration Page." do

    let(:registration_page) { PageObjects::RegistrationPage.new }

    it "Load Registration page" do
      I18n.locale = locale
      registration_page.load(locale: locale)
    end

    it "Should show text |#{I18n.t 'ui_tests.registration_page.label_join_us'}|." do
      expect(registration_page).to have_text(I18n.t 'ui_tests.registration_page.label_join_us')
    end

    it "Should show text |#{I18n.t 'ui_tests.registration_page.label_sign_in'}|." do
      expect(registration_page).to have_text(I18n.t 'ui_tests.registration_page.label_sign_in')
    end

    it "Should show button_vk |#{I18n.t 'ui_tests.registration_page.button_vk'}|." do
      expect(registration_page.button_vk.text).to eq(I18n.t 'ui_tests.registration_page.button_vk')
    end

    it "Should show button_fb |#{I18n.t 'ui_tests.registration_page.button_fb'}|." do
      expect(registration_page.button_fb.text).to eq(I18n.t 'ui_tests.registration_page.button_fb')
    end

    it "Should show text |#{I18n.t 'ui_tests.registration_page.label_or'}|." do
      expect(registration_page).to have_text(I18n.t 'ui_tests.registration_page.label_or')
    end

    it "Should show text |#{I18n.t 'ui_tests.registration_page.label_register_email'}|." do
      expect(registration_page).to have_text(I18n.t 'ui_tests.registration_page.label_register_email')
    end

    it "Should show Your nickname field with placeholder |#{I18n.t 'ui_tests.registration_page.hint_nickname'}|." do
      expect(registration_page).to have_field(registration_page.fields.hint_nickname[:id], placeholder: (I18n.t 'ui_tests.registration_page.hint_nickname'))
    end

    it "Should show Email field with placeholder |#{I18n.t 'ui_tests.registration_page.hint_email'}|." do
      expect(registration_page).to have_field(registration_page.fields.hint_email[:id], placeholder: (I18n.t 'ui_tests.registration_page.hint_email'))
    end

    it "Should show Password field with placeholder |#{I18n.t 'ui_tests.registration_page.hint_password'}|." do
      expect(registration_page).to have_field(registration_page.fields.hint_password[:id], placeholder: (I18n.t 'ui_tests.registration_page.hint_password'))
    end

    it "Should show Repeat Password field with placeholder |#{I18n.t 'ui_tests.registration_page.hint_repeat_password'}|" do
      expect(registration_page).to have_field(registration_page.fields.hint_repeat_password[:id], placeholder: (I18n.t 'ui_tests.registration_page.hint_repeat_password'))
    end

    it "Should show button_fb |#{I18n.t 'ui_tests.registration_page.button_sign_up'}|" do
      expect(registration_page.button_sign_up[:value]).to eq(I18n.t 'ui_tests.registration_page.button_sign_up')
    end
    
  end
end
