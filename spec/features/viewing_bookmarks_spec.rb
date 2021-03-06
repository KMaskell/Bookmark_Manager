# frozen_string_literal: true

feature 'Viewing bookmarks' do
  feature 'visiting the homepage' do
    scenario 'the page title is visible' do
      visit('/')

      expect(page).to have_content 'Bookmark Manager'
    end
  end

  feature 'viewing bookmarks' do
    scenario 'bookmarks are visible' do
      Bookmark.create(url: 'http://www.google.com', title: 'Google')
      Bookmark.create(url: 'http://www.lwlies.com', title: 'Little White Lies')
      Bookmark.create(url: 'http://www.ocado.com', title: 'Ocado')

      visit '/bookmarks'

      expect(page).to have_content('Google', url: 'http://www.google.com')
      expect(page).to have_content('Little White Lies',  url: 'http://www.lwlies.com')
      expect(page).to have_content('Ocado', url: 'http://www.ocado.com')
    end
  end
end
