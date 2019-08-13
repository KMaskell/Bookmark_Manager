# frozen_string_literal: true

require 'sinatra/base'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base
  get '/' do
    'Bookmark Manager'
  end

  get '/bookmarks' do
    p ENV
    
    @bookmarks = Bookmark.all
    erb :bookmarks
  end

  run! if app_file == $PROGRAM_NAME
end
