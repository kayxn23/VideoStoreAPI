class CustomersController < ApplicationController
  def index
    customers = Customer.all

    if !customer_params["sort"].nil?
      customers = Customer.order(customer_params["sort"])
      render json: customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count]),
      status: :ok
    else
      render json: customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count]),
      status: :ok
    end
  end

  private

  def customer_params
    params.permit(:sort, :n, :p)
  end

end
