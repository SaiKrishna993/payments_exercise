class PaymentForm
  include ActiveModel::Model
  attr_accessor :amount, :date

  validates :amount, numericality: { greater_than: 0 }, allow_nil: false

  validate :outstanding_amount

  def initialize(loan, params = {})
    @loan = loan
    @amount = params[:amount]
    @date = Date.current
  end

  def attributes
    {
      amount: amount,
      date: date
    }
  end

  private

    def outstanding_amount
      return if @amount.to_f <= @loan.outstanding_amount

      errors.add(:amount, 'exceeds the outstanding balance of a loan')
    end
end