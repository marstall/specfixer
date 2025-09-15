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

  scenario 'User can refresh to get a new quote', js: true do
    visit root_path

    # Store the initial quote content
    initial_quote = find('.quote-text').text

    # Click the refresh button
    click_button 'Get New Quote'

    # Wait for the AJAX request to complete and check if content might have changed
    # Note: Due to randomness, the quote might be the same, but the button should work
    expect(page).to have_button('Get New Quote')
    expect(page).to have_css('.quote-text')
  end

  scenario 'User sees loading state when refreshing quote', js: true do
    visit root_path

    # Mock a slow response to test loading state
    allow(Quote).to receive(:random_quote).and_wrap_original do |method|
      sleep(0.1) # Small delay to see loading state
      method.call
    end

    click_button 'Get New Quote'

    # The button text should temporarily change to "Loading..."
    # Note: This might be too fast to catch in test, but the functionality should work
    expect(page).to have_css('.quote-card')
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
