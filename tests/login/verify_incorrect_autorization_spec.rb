require 'spec_helper'

I18n.available_locales.each do |locale|
  describe "#{locale.upcase} Verify errors when user try login with not confirmated account." do

    let(:login_page) {PageObjects::LoginPage.new}

    password = Faker::Internet.password(8)
    email = Faker::Internet.safe_email
    nick = Faker::Lorem.characters(6)

    it "Pre-conditions." do
      I18n.locale = locale
      login_page.load(locale: locale)
      delete_user_if_available(email)
      User.create(email: email, password: password, nick: nick)
    end

    context "Verify not confirmated error." do
      it "Enter email and password." do
        login_page.fields.hint_email.set(email)
        login_page.fields.hint_password.set(password)
      end

      it "Click Sign In." do
        login_page.button_sign_in.click
      end

      it "Should show error |#{I18n.t 'ui_tests.login_page.errors.not_confirmed'}|." do
        expect(login_page).to have_text(I18n.t 'ui_tests.login_page.errors.not_confirmed')
      end
    end

    context "Verify lock account." do
      it "Confirmate user." do
        User.last.update(confirmed_at: Time.now.utc)
      end

      it "9 times enter incorrect password." do
        9.times do
          login_page.fields.hint_email.set(email)
          login_page.fields.hint_password.set(email)
          login_page.button_sign_in.click
        end
      end

      it "Should show notification about last chance |#{I18n.t 'ui_tests.login_page.errors.last_try'}|." do
        expect(login_page).to have_text(I18n.t 'ui_tests.login_page.errors.last_try')
      end

      it "10th time enter incorrect password" do
        login_page.fields.hint_email.set(email)
        login_page.fields.hint_password.set(email)
        login_page.button_sign_in.click
      end

      it "Should show notification about lock account |#{I18n.t 'ui_tests.login_page.errors.last_try'}|." do
        expect(login_page).to have_text(I18n.t 'ui_tests.login_page.errors.account_lock')
      end

      context "Verfiy account is lock" do
        it "Enter correct Email and Password" do
          login_page.fields.hint_email.set(email)
          login_page.fields.hint_password.set(password)
          login_page.button_sign_in.click
        end

        it "Should show notification about lock account |#{I18n.t 'ui_tests.login_page.errors.last_try'}|." do
          expect(login_page).to have_text(I18n.t 'ui_tests.login_page.errors.account_lock')
        end
      end
    end
    
  end
end
