feature 'User signs out' do
  scenario 'successfully' do
    sign_up
    sign_in
    click_button 'Sign out'
    expect(current_path).to eq '/links'
    expect(page).to have_content 'Goodbye!'
    expect(page).not_to have_content 'Welcome'
  end
end
