# Payments Exercise

Add in the ability to create payments for a given loan using a JSON API call. You should store the payment date and amount. Expose the outstanding balance for a given loan in the JSON vended for `LoansController#show` and `LoansController#index`. The outstanding balance should be calculated as the `funded_amount` minus all of the payment amounts.

A payment should not be able to be created that exceeds the outstanding balance of a loan. You should return validation errors if a payment can not be created. Expose endpoints for seeing all payments for a given loan as well as seeing an individual payment.



# Solution

Payment:-
  Added payment model with amount and date, also payments controller which accepts and show the payments, validating and setting defaults to the payments is handled by `payment_form`, and creating payments is handled by `create_payment` service.

Loan:-
  On loans added new attribute called `outstanding_amount` which will get updated after successful payment creation and will maintain the outstanding amount for loan

used separate presenters to return the objects, this way we have more control over the payload we are returning.

Added requests specs for both loan and payments controller which covers the full flow.
Have updated the application to latest rails version and added few other requred gems.