# As a time-pressed user
# So that I can quickly go to web sites I regularly visit
# I would like to see a list of links on the homepage

feature 'User can visit homepage and see list of links' do
  scenario 'visits webpage, expects to have content' do
    visit '/links'
    expect(page).to have_content("My Bookmarks!")
  end

  scenario 'DataMapper creates a link' do
    Link.create(:url => 'http://petcapybara.com', :title => 'Capybaras')
    visit '/links'
    within 'ul#links' do
    expect(page).to have_content('Capybaras')
    end
  end
end
