# As a time-pressed user
# So that I can save a website
# I would like to add the site's address and title to my bookmark manager
feature 'create links' do
    scenario "add the site's address and title" do
      visit '/links/new'
      fill_in(:title, with: 'Oh yeah, Capybara!')
      fill_in(:url, with: 'http://www.ohyeahcapybara.com')
      click_button('Submit')
      expect(current_path).to eq '/links'
      within 'ul#links' do
        expect(page).to have_content('Title: Oh yeah, Capybara!')
      end
    end
end
