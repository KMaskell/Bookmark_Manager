require 'bookmark'
require 'pg'

describe Bookmark do
  describe '.all' do
    it 'returns a list of bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')
      
      connection.exec("INSERT INTO bookmarks (url) VALUES ('http://www.google.com');")
      connection.exec("INSERT INTO bookmarks (url) VALUES ('http://www.lwlies.com');")
      connection.exec("INSERT INTO bookmarks (url) VALUES ('http://www.ocado.com');")

      bookmarks = Bookmark.all

      expect(bookmarks).to include('http://www.google.com')
      expect(bookmarks).to include('http://www.lwlies.com')
      expect(bookmarks).to include('http://www.ocado.com')
    end
  end
  
    describe '.create' do
      it 'creates a new bookmark' do
        Bookmark.create(url: 'http://www.testbookmark.com')

        expect(Bookmark.all).to include 'http://www.testbookmark.com'
      end
    end
end
