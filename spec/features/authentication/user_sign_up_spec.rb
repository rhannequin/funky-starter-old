require 'rails_helper'

feature 'Sign up' do
  let!(:user) { build(:user) }
  background do
    visit root_path
    click_link I18n.t(:'devise.registrations.new.sign_up')
  end

  describe 'when user provides valid credentials' do
    background do
      fill_in I18n.t(:'mongoid.attributes.user.email'), with: user.email
      find('#user_password').set 'password'
      find('#user_password_confirmation').set 'password'
      click_button I18n.t(:'devise.registrations.new.sign_up')
    end

    scenario 'he should be logged in' do
      expect(page).to have_content I18n.t(:'devise.registrations.signed_up')
      expect(current_path).to eq(root_path)
      expect(User.where(email: user.email)).not_to be_nil
    end
  end
end
