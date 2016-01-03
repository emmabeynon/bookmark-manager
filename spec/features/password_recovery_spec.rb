feature 'Reset password' do
  before do
   sign_up
   Capybara.reset!
 end

 let(:user) { User.first }
  scenario 'User clicks on forgotten password button' do
    visit '/sessions/new'
    fill_in :email,    with: 'blah@blah.com'
    fill_in :password, with: 'wrong password'
    click_button 'Sign in'
    click_link 'Forgotten password?'
    expect(page).to have_content 'Please enter your email address'
  end

  scenario 'User submits email address for recovery and gets acknowledgement message' do
    click_forgotten_password
    expect(current_path).to eq '/users/forgotten-password'
    fill_in :email,    with: 'blah@blah.com'
    click_button 'Recover password'
    expect(page).to have_content 'You have submitted a password recovery request.
    Please check your inbox.'
  end

  scenario 'User is assigned a reset token when they recover password' do
    sign_up
    click_forgotten_password
    expect{click_recover_password}.to change{User.first.password_token}
  end

  scenario 'User submits token and resets password if valid' do
    click_forgotten_password
    click_recover_password
    visit '/users/recover'
  end

  scenario 'submits token and password cannot be reset if invalid' do
    click_recover_password
    Timecop.travel(60 * 60 * 60) do
      visit("/users/reset-password?token=#{user.password_token}")
      expect(page).to have_content "Your token is invalid."
    end
  end

  scenario 'asks for new password when token is valid' do
    click_recover_password
    visit("/users/reset-password?token=#{user.password_token}")
    expect(page).to have_content "Please enter a new password"
  end

  xscenario 'signs in with new password' do

  end
end
