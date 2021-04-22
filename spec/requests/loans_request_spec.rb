require 'rails_helper'
RSpec.describe 'Loans', type: :request do
  let(:header) do
    {
      Accept: 'application/json'
    }
  end

  let(:loan){ FactoryBot.create(:loan) }

  before do
    host! 'api.example.com'
  end

  describe 'GET' do
    before do
      FactoryBot.create(:payment, loan: loan)
    end

    context '#index' do
      it 'list all the loans' do
        get "/loans", headers: header

        expect(response.status).to eq(200)
        body = JSON.parse(response.body)
        expect(body.count).to eq(1)
        expect(body.first['payments']).to be_present
      end
    end

    context '#show' do
      it 'show single loan' do
        get "/loans/#{loan.id}", headers: header

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)['id']).to eq(loan.id)
      end
    end
  end
end