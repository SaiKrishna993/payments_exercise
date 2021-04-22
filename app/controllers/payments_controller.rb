class PaymentsController < ActionController::API
  before_action :loan, only: [:create]

  def index
    render json: PaymentPresenter.list(Payment.where(loan_id: params[:loan_id]))
  end

  def show
    render json: PaymentPresenter.single(Payment.find(params[:id]))
  end

  def create
    form = PaymentForm.new(loan, payment_params)
    if form.valid?
      payment = CreatePayment.call(loan, form.attributes).payment
      render json: PaymentPresenter.single(payment)
    else
      render json: { errors: form.errors }, status: :unprocessable_entity
    end
  end

  private

    def loan
      @loan ||= Loan.find(params[:loan_id])
    end

    def payment_params
      @payment_params ||= params[:payment].permit(:amount)
    end
end
