require 'rails_helper'
RSpec.describe 'Payments', type: :request do
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
      it 'list all the loan payments' do
        get "/loans/#{loan.id}/payments", headers: header

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body).count).to eq(1)
      end
    end

    context '#show' do
      it 'show single loan payment' do
        get "/payments/#{Payment.last.id}", headers: header

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)['id']).to eq(Payment.last.id)
      end
    end
  end

  describe 'POST' do
    subject(:create_payment) do
      post "/loans/#{loan.id}/payments",
            params: {
              payment: {
                amount: amount
              }
            },
            headers: header
    end

    context 'with correct payment' do
      let(:amount) { 10 }
      it 'creates new payemnt' do
        create_payment
        expect(response.status).to eq(200)
        body = JSON.parse(response.body)
        expect(body['date']).to eq(Date.current.to_s)
        loan.reload
        expect(loan.payments.count).to eq(1)
        expect(loan.outstanding_amount).to eq(190)
      end
    end

    context 'with wrong payment' do
      let(:amount) { 'ss' }
      it 'creates new payemnt' do
        create_payment
        expect(response.status).to eq(422)
        body = JSON.parse(response.body)
        expect(body["errors"]["amount"]).to be_present
      end
    end

    context 'with payment gt outstanding_amount' do
      let(:amount) { 400 }
      it 'creates new payemnt' do
        create_payment
        expect(response.status).to eq(422)
        body = JSON.parse(response.body)
        expect(body["errors"]["amount"]).to be_present
      end
    end
  end
end