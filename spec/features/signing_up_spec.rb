feature 'User Sign up' do
  scenario "creates a new user" do
    visit '/users/new'
    expect(page.status_code).to eq 200
    fill_in(:email, with: 'chris.wynndow@gmail.com')
    fill_in(:name, with: 'Chris')
    fill_in(:password, with: 'password')
    fill_in :password_confirmation, with: 'password'
    expect { click_button('Sign up') }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, Chris!')
    expect(User.last.email).to eq 'chris.wynndow@gmail.com'
  end

  scenario 'with incorrect password confirmation' do
    visit '/users/new'
    expect(page.status_code).to eq(200)
    fill_in :name, with: 'Blah Blah'
    fill_in :email,    with: 'blah@blah.com'
    fill_in :password, with: 'blahblah'
    fill_in :password_confirmation, with: 'blahblahblah'
    expect{ click_button 'Sign up' }.not_to change(User, :count)
    expect(current_path).to eq('/users/new')
    expect(page).to have_content 'Password does not match the confirmation'
  end

  scenario 'with a blank email address' do
    visit '/users/new'
    fill_in :name, with: 'Blah Blah'
    fill_in :password, with: 'blahblahblah'
    fill_in :password_confirmation, with: 'blahblahblah'
    expect{ click_button 'Sign up' }.not_to change(User, :count)
    expect(page).to have_content 'Email must not be blank'
  end

  scenario 'with an invalid email address' do
    visit '/users/new'
    fill_in :name, with: 'Blah Blah'
    fill_in :email,    with: 'blah@blah'
    fill_in :password, with: 'blahblahblah'
    fill_in :password_confirmation, with: 'blahblahblah'
    expect{ click_button 'Sign up' }.not_to change(User, :count)
    expect(page).to have_content 'Email has an invalid format'
  end

  scenario 'with an already registered email address' do
    sign_up
    visit '/users/new'
    fill_in :name, with: 'Blah Blah'
    fill_in :email,    with: 'blah@blah.com'
    fill_in :password, with: 'blahblahblah'
    fill_in :password_confirmation, with: 'blahblahblah'
    expect{ click_button 'Sign up' }.not_to change(User, :count)
    expect(page).to have_content 'Email is already taken'
  end

end
