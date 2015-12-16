# As a time-pressed user
# So that I can save a website
# I would like to add the site's address and title to my bookmark manager
feature 'create links' do
    scenario "add the site's address and title" do
      visit '/users/new'
      expect(page.status_code).to eq 200
      fill_in(:email, with: 'chris.wynndow@gmail.com')
      fill_in(:name, with: 'Chris')
      fill_in(:password, with: 'password')
      expect { click_button('Sign up') }.to change(User, :count).by(1)
      expect(page).to have_content('Welcome, Chris!')
      expect(User.last.email).to eq 'chris.wynndow@gmail.com'
    end
end
