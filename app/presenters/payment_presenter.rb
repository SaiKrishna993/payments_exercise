module PaymentPresenter
  def self.single(payment)
    {
      id: payment.id,
      loan_id: payment.loan_id,
      amount: payment.amount,
      date: payment.date
    }
  end

  def self.list(payments)
    payments.map do |payment|
      single(payment)
    end
  end
end