# require 'pg'
# require 'bookmark'

feature 'Viewing bookmarks' do
  scenario 'bookmarks are visible' do
    Bookmark.create(url: "http://www.google.com", title: 'Google')
    Bookmark.create(url: "http://www.lwlies.com", title: 'Little White Lies')
    Bookmark.create(url: "http://www.ocado.com", title: 'Ocado')

    visit('/bookmarks')

    expect(page).to have_link('Google', href: "http://www.google.com")
    expect(page).to have_link('Little White Lies', href: "http://www.lwlies.com")
    expect(page).to have_link('Ocado', href: "http://www.ocado.com")
  end
end