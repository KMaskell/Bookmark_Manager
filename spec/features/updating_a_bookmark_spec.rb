feature 'Updating a bookmark' do
    scenario 'A user can update a bookmark' do
        bookmark = Bookmark.create(url: "http://www.google.com", title: 'Google')
        visit('/bookmarks')
        expect(page).to have_link('Google', href: "http://www.google.com")

        first('.bookmark').click_button 'Edit'
        expect(current_path).to eq "/bookmarks/#{bookmark.id}/edit"

        fill_in('url', with: "http://www.bbcweather.co.uk")
        fill_in('title', with: 'BBC Weather')
        click_button('Submit')

        expect(current_path).to eq '/bookmarks'
        expect(page).not_to have_link('Google', href: "http://www.google.com")
        expect(page).to have_link('BBC Weather', href: "http://www.bbcweather.co.uk")
    end
end