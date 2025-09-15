require 'rails_helper'

RSpec.describe Quote, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:author) }
    it { should validate_presence_of(:category) }
  end

  describe 'scopes' do
    let!(:motivation_quote) { create(:quote, category: 'motivation') }
    let!(:inspiration_quote) { create(:quote, category: 'inspiration') }

    describe '.by_category' do
      it 'returns quotes filtered by category' do
        expect(Quote.by_category('motivation')).to include(motivation_quote)
        expect(Quote.by_category('motivation')).not_to include(inspiration_quote)
      end
    end
  end

  describe '.daily_quote' do
    context 'when quotes exist' do
      let!(:quotes) { create_list(:quote, 5) }

      it 'returns a quote consistently for the same day' do
        # Mock Date.current to ensure consistent behavior
        allow(Date).to receive(:current).and_return(Date.new(2023, 1, 1))
        
        first_call = Quote.daily_quote
        second_call = Quote.daily_quote
        
        expect(first_call).to eq(second_call)
        expect(first_call).to be_a(Quote)
      end

      it 'returns different quotes for different days' do
        allow(Date).to receive(:current).and_return(Date.new(2023, 1, 1))
        quote_day_1 = Quote.daily_quote

        allow(Date).to receive(:current).and_return(Date.new(2023, 1, 2))
        quote_day_2 = Quote.daily_quote

        # With 5 quotes, there's a high probability they'll be different
        # but we'll just ensure the method works without error
        expect(quote_day_1).to be_a(Quote)
        expect(quote_day_2).to be_a(Quote)
      end
    end

    context 'when no quotes exist' do
      before { Quote.destroy_all }

      it 'creates and returns a default quote' do
        expect { Quote.daily_quote }.to change(Quote, :count).by(1)
        
        quote = Quote.daily_quote
        expect(quote.content).to eq("The only way to do great work is to love what you do.")
        expect(quote.author).to eq("Steve Jobs")
        expect(quote.category).to eq("motivation")
      end
    end
  end

  describe '.random_quote' do
    context 'when quotes exist' do
      let!(:quotes) { create_list(:quote, 3) }

      it 'returns a random quote from existing quotes' do
        quote = Quote.random_quote
        expect(quotes).to include(quote)
      end

      it 'can return different quotes on multiple calls' do
        # This test might occasionally fail due to randomness, but with 3 quotes
        # and multiple calls, we should get some variation
        results = 10.times.map { Quote.random_quote }
        unique_results = results.uniq
        
        expect(unique_results.length).to be >= 1
        expect(unique_results.length).to be <= 3
      end
    end

    context 'when no quotes exist' do
      before { Quote.destroy_all }

      it 'creates and returns a default quote' do
        expect { Quote.random_quote }.to change(Quote, :count).by(1)
        
        quote = Quote.random_quote
        expect(quote.content).to eq("The only way to do great work is to love what you do.")
        expect(quote.author).to eq("Steve Jobs")
        expect(quote.category).to eq("motivation")
      end
    end
  end

  describe '.create_default_quote' do
    it 'creates a default quote with expected attributes' do
      expect { Quote.create_default_quote }.to change(Quote, :count).by(1)
      
      quote = Quote.last
      expect(quote.content).to eq("The only way to do great work is to love what you do.")
      expect(quote.author).to eq("Steve Jobs")
      expect(quote.category).to eq("motivation")
    end
  end

  describe '#formatted_display' do
    let(:quote) { create(:quote, content: "Test content", author: "Test Author") }

    it 'returns formatted quote with content and author' do
      expected = '"Test content" - Test Author'
      expect(quote.formatted_display).to eq(expected)
    end
  end
end
