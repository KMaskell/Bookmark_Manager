require 'bookmark'
require 'database_helpers'

describe Bookmark do
  #let(:bookmark) { double('bookmark', url: 'http://www.testbookmark.com', title: 'Test Bookmark') }

  describe '.all' do
    it 'returns a list of bookmarks' do
      # connection = PG.connect(dbname: 'bookmark_manager_test')
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

  describe '.update' do
    it 'updates the bookmark with the given data' do
      bookmark = Bookmark.create(title: 'Google', url: "http://www.google.com")
      updated_bookmark = Bookmark.update(id: bookmark.id, url: "http://www.bbcweather.co.uk", title: 'BBC Weather')

      expect(updated_bookmark).to be_a Bookmark
      expect(updated_bookmark.id).to eq bookmark.id
      expect(updated_bookmark.title).to eq 'BBC Weather'
      expect(updated_bookmark.url).to eq 'http://www.bbcweather.co.uk'
    end
  end

  describe '.find' do
    it 'returns the requested bookmark object' do
      bookmark = Bookmark.create(title: 'Google', url: "http://www.google.com")

      result = Bookmark.find(id: bookmark.id)

      expect(result).to be_a Bookmark
      expect(result.id).to eq bookmark.id
      expect(result.title).to eq 'Google'
      expect(result.url).to eq "http://www.google.com"
    end
  end
end
