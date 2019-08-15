require 'bookmark'
#require 'pg'
require 'database_helpers'

describe Bookmark do
  #let(:bookmark) { double('bookmark', url: 'http://www.testbookmark.com', title: 'Test Bookmark') }

  describe '.all' do
    it 'returns a list of bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')
      # connection.exec("INSERT INTO bookmarks (title, url) VALUES('Google')

      bookmark = Bookmark.create(url: "http://www.google.com", title: "Google")
      Bookmark.create(url: "http://www.lwlies.com", title: "Little White Lies")
      Bookmark.create(url: "http://ocado.com", title: "Ocado")

      bookmarks = Bookmark.all

      expect(bookmarks.length).to eq 3
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq "Google"
      expect(bookmarks.first.url).to eq "http://www.google.com"
    end
  end

  describe '.create' do
    it 'creates a new bookmark' do
      bookmark = Bookmark.create(url: "http://www.testbookmark.com", title: "Test Bookmark")
      persisted_data = persisted_data(id: bookmark.id)

      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data.first['id']
      expect(bookmark.title).to eq "Test Bookmark"
      expect(bookmark.url).to eq "http://www.testbookmark.com"
    end
  end
end
