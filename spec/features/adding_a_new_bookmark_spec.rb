# frozen_string_literal: true

feature 'User has to enter a valid URL' do
  scenario 'The bookmark must be a valid URL' do
    visit '/bookmarks/new'
    fill_in('url', with: 'jodiisthebest')
    click_button('Submit')

    expect(page).not_to have_content 'jodiisthebest'
    expect(page).to have_content 'Please submit a valid URL'
  end
end
