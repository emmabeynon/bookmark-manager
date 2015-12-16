# As a time-pressed user
# So that I can organise my links into different categories for ease of search
# I would like to add tags to the links in my bookmark manager

feature 'Multiple Tagging links' do
  scenario 'add multiple tags to a new link' do
    visit '/links/new'
    fill_in(:title, with: 'Elf Your self!')
    fill_in(:url, with: 'http://elfyourself.com/?mId=66826127.3')
    fill_in(:tags, with: 'Christmas, Festive, Elves')
    click_button('Submit')
    link = Link.first
    expect(link.tags.map(&:name)).to include('Christmas')
    expect(link.tags.map(&:name)).to include('Festive')
    expect(link.tags.map(&:name)).to include('Elves')
  end
end
