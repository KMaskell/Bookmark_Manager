require 'pg'

class Bookmark
  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end

  def self.all
    connection = select_env
    result = connection.exec("SELECT * FROM bookmarks")
    result.map do |bookmark|
      Bookmark.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url'])
    end
  end

  def self.create(title:, url:)
    # return false unless is_url?(url)
    connection = select_env
    result = connection.exec("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}') RETURNING id, title, url;")
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.delete(title)
    connection = select_env
    connection.exec("DELETE FROM bookmarks WHERE title = '#{title}';")
  end

  def self.delete(id:)
    connection = select_env
    connection.exec("DELETE FROM bookmarks WHERE ID = #{id};")
  end

  # def self.is_url?(url)
  #   url
  # end

  private

  def self.select_env
    if ENV['ENVIRONMENT'] == 'test'
      PG.connect(dbname: 'bookmark_manager_test')
    else
      PG.connect(dbname: 'bookmark_manager')
    end
  end
end
