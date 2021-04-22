module LoanPresenter
  def self.single(loan)
    {
      id: loan.id,
      funded_amount: loan.funded_amount,
      outstanding_amount: loan.outstanding_amount,
      payments: PaymentPresenter.list(loan.payments)
    }
  end

  def self.list(loans)
    loans.map do |loan|
      single(loan)
    end
  end
end