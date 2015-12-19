feature 'User signs in' do
  scenario 'with correct credentials' do
    sign_up
    visit '/sessions/new'
    expect(page.status_code).to eq 200
    fill_in :email,    with: 'blah@blah.com'
    fill_in :password, with: 'blahblahblah'
    click_button 'Sign in'
    expect(page).to have_content 'Welcome, Blah Blah'
  end

  scenario 'and fails with incorrect credentials' do
    sign_up
    visit '/sessions/new'
    expect(page.status_code).to eq 200
    fill_in :email,    with: 'blah@blah.com'
    fill_in :password, with: 'blahblah'
    click_button 'Sign in'
    expect(page).to have_content 'The email or password is incorrect'
  end
end
