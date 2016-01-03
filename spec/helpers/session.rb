module SessionHelpers

  def sign_up
    visit '/users/new'
    fill_in :name, with: 'Blah Blah'
    fill_in :email,    with: 'blah@blah.com'
    fill_in :password, with: 'blahblahblah'
    fill_in :password_confirmation, with: 'blahblahblah'
    click_button('Sign up')
  end

  def sign_in
    visit '/sessions/new'
    fill_in :email,    with: 'blah@blah.com'
    fill_in :password, with: 'blahblahblah'
    click_button 'Sign in'
    expect(current_path).to eq '/links'
  end

  def click_forgotten_password
    visit '/sessions/new'
    click_link 'Forgotten password?'
  end

  def click_recover_password
    visit '/users/forgotten-password'
    fill_in :email,    with: 'blah@blah.com'
    click_button 'Recover password'
  end


end
