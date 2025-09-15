require 'rails_helper'

RSpec.feature 'Quote of the Day', type: :feature do
  let!(:quotes) { create_list(:quote, 3) }

  scenario 'User visits the homepage and sees a quote of the day' do
    visit root_path

    expect(page).to have_content('Welcome to SpecFixer')
    expect(page).to have_content('Quote of the Day')
    expect(page).to have_css('.quote-card')
    expect(page).to have_css('.quote-text')
    expect(page).to have_css('.quote-author')
    expect(page).to have_css('.quote-category')
  end

  scenario 'User can see quote content and attribution' do
    quote = quotes.first
    allow(Quote).to receive(:daily_quote).and_return(quote)

    visit root_path

    expect(page).to have_content(quote.content)
    expect(page).to have_content(quote.author)
    expect(page).to have_content(quote.category.titleize)
  end

  scenario 'User can see the refresh quote button' do
    visit root_path

    # Check that the refresh functionality is available
    expect(page).to have_button('Get New Quote')
    expect(page).to have_css('#refresh-quote-btn')
    expect(page).to have_css('#quote-container')
  end

  scenario 'Refresh quote endpoint works correctly' do
    quote = create(:quote, content: "Test refresh quote", author: "Test Author")
    allow(Quote).to receive(:random_quote).and_return(quote)

    # Test the refresh_quote endpoint directly
    visit refresh_quote_path

    expect(page).to have_content("Test refresh quote")
    expect(page).to have_content("Test Author")
  end

  scenario 'Homepage displays feature cards' do
    visit root_path

    expect(page).to have_content('Features')
    expect(page).to have_content('Daily Inspiration')
    expect(page).to have_content('Random Quotes')
    expect(page).to have_content('Curated Collection')
  end

  scenario 'Quote card displays properly formatted content' do
    quote = create(:quote, 
                  content: "Test quote content", 
                  author: "Test Author", 
                  category: "test")
    allow(Quote).to receive(:daily_quote).and_return(quote)

    visit root_path

    within('.quote-card') do
      expect(page).to have_content('"Test quote content"')
      expect(page).to have_content('— Test Author')
      expect(page).to have_content('Test')
    end
  end

  scenario 'Page handles empty quote gracefully' do
    allow(Quote).to receive(:daily_quote).and_return(nil)

    visit root_path

    within('.quote-card') do
      expect(page).to have_content('No quotes available at the moment.')
      expect(page).to have_content('— SpecFixer')
      expect(page).to have_content('System')
    end
  end

  scenario 'Page is responsive and displays properly' do
    visit root_path

    # Check that main elements are present
    expect(page).to have_css('.container')
    expect(page).to have_css('.hero-section')
    expect(page).to have_css('.quote-section')
    expect(page).to have_css('.features-section')
    
    # Check that the page has proper styling classes
    expect(page).to have_css('.main-title')
    expect(page).to have_css('.subtitle')
    expect(page).to have_css('.section-title')
  end
end
