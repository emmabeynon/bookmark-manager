# As a time-pressed user
# So that I can quickly find links on a particular topic
# I would like to filter links by tag
feature 'Filter Tags' do
  scenario 'filter links by bubbles tag' do
    visit '/links/new'
    fill_in(:title, with: 'Oh yeah, Capybara!')
    fill_in(:url, with: 'http://www.ohyeahcapybara.com')
    fill_in(:tags, with: 'Capybaras')
    click_button('Submit')
    click_button('Add bookmark!')
    fill_in(:title, with: 'Bubble Game')
    fill_in(:url, with: 'http://www.bubblegame.org')
    fill_in(:tags, with: 'bubbles')
    click_button('Submit')
    visit '/tags/bubbles'
    expect(page.status_code).to eq 200
    link = Link.all
    expect(page).not_to have_content('Capybaras')
    expect(page).to have_content('bubbles')
  end
end
