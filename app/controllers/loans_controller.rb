class LoansController < ApplicationController
  def index
    render json: LoanPresenter.list(Loan.includes(:payments).all)
  end

  def show
    render json: LoanPresenter.single(Loan.includes(:payments).find(params[:id]))
  end
end
