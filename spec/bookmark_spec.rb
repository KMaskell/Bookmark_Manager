# frozen_string_literal: true

require 'bookmark'
require 'pg'
require 'database_helpers'

describe Bookmark do
  let(:bookmark) { double('bookmark', url: 'http://www.testbookmark.com', title: 'Test Bookmark') }

  describe '.all' do
    it 'returns a list of bookmarks' do
      # connection = PG.connect(dbname: 'bookmark_manager_test')
      # connection.exec("INSERT INTO bookmarks (title, url) VALUES('Google')

      Bookmark.create('http://www.google.com', 'Google')
      Bookmark.create('http://lwlies.com', 'Little White Lies')
      Bookmark.create('http://ocado.com', 'Ocado')

      bookmarks = Bookmark.all

      expect(bookmarks.length).to eq 3
      expect(bookmarks.first).to be_a Bookmark
      # expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Google'
      expect(bookmarks.first.url).to eq 'http://www.google.com'
    end
  end

  describe '.create' do
    it 'creates a new bookmark' do
      # bookmark = Bookmark.create('http://www.testbookmark.com', 'Test Bookmark')
      # persisted_data = persisted_data(bookmark.id)

      Bookmark.create(bookmark.url, bookmark.title)
      connection = PG.connect(dbname: 'bookmark_manager_test')
      results = connection.exec('SELECT * FROM bookmarks;')
      expect(results[0]['url']).to eq bookmark.url
      expect(results[0]['title']).to eq bookmark.title

      # expect(bookmark).to be_a Bookmark
      # expect(bookmark.id).to eq persisted_data(bookmark.id)['id']
      # expect(bookmark.title).to eq 'Test Bookmark'
      # expect(bookmark.url).to eq 'http://www.testbookmark.com'
    end
  end

  describe '.delete' do
    it 'deletes a bookmark' do

      Bookmark.create(bookmark.url, bookmark.title)
      Bookmark.delete(bookmark.title)

      connection = PG.connect(dbname: 'bookmark_manager_test')
      results = connection.exec('SELECT * FROM bookmarks;')

      expect(results.to_a).to be_empty
      
    end
  end
end
