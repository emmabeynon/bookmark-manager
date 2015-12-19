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
  end

end
