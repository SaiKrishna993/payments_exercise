class CreatePayment
  attr_reader :payment

  def self.call(loan, attributes, options = {})
    new(loan, attributes, options).call
  end

  def initialize(loan, attributes, options)
    @loan = loan
    @attributes = attributes
  end
  def call
    ActiveRecord::Base.transaction do
      @payment = create_payment
      update_loan_outstanding
    end

    self
  end

  private

    def create_payment
      @loan.payments.create!(amount: @attributes[:amount], date: @attributes[:date])
    end

    def update_loan_outstanding
      outstanding_amount = @loan.outstanding_amount - @payment.amount
      @loan.update!(outstanding_amount: outstanding_amount)
    end
end