require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET #index' do
    let!(:quote) { create(:quote) }

    before do
      allow(Quote).to receive(:daily_quote).and_return("quote")
    end

    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns @quote_of_the_day' do
      get :index
      expect(assigns(:quote_of_the_day)).to eq(quote)
    end

    it 'calls Quote.daily_quote' do
      expect(Quote).to receive(:daily_quote).once
      get :index
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #refresh_quote' do
    let!(:quote) { create(:quote, :inspiration) }

    before do
      allow(Quote).to receive(:random_quote).and_return(quote)
    end

    context 'when requested via AJAX' do
      it 'returns http success' do
        get :refresh_quote, xhr: true
        expect(response).to have_http_status(:success)
      end

      it 'assigns @quote_of_the_day with a random quote' do
        get :refresh_quote, xhr: true
        expect(assigns(:quote_of_the_day)).to eq(quote)
      end

      it 'calls Quote.random_quote' do
        expect(Quote).to receive(:random_quote).once
        get :refresh_quote, xhr: true
      end

      it 'renders the quote_card partial' do
        get :refresh_quote, xhr: true
        expect(response).to render_template(partial: '_quote_card')
      end
    end

    context 'when requested normally (non-AJAX)' do
      it 'returns http success' do
        get :refresh_quote
        expect(response).to have_http_status(:success)
      end

      it 'still assigns @quote_of_the_day' do
        get :refresh_quote
        expect(assigns(:quote_of_the_day)).to eq(quote)
      end
    end
  end
end
