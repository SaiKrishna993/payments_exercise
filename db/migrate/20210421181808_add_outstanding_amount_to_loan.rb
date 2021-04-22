class AddOutstandingAmountToLoan < ActiveRecord::Migration[6.1]
  def change
    add_column :loans, :outstanding_amount, :float
  end
end
