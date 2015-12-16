# As a time-pressed user
# So that I can organise my many links into different categories for ease of search
# I would like to tag links in my bookmark manager

feature 'Tagging links' do
  scenario 'add a single tag to a new link' do
    visit '/links/new'
    fill_in(:title, with: 'Oh yeah, Capybara!')
    fill_in(:url, with: 'http://www.ohyeahcapybara.com')
    fill_in(:tags, with: 'Capybaras')
    click_button('Submit')
    link = Link.first
    expect(link.tags.map(&:name)).to include('Capybaras')
  end
end
