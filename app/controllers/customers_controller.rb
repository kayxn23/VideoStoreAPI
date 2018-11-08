class CustomersController < ApplicationController

  SORTABLE_ATTRIBUTES = [:name, :registered_at, :postal_code]

  def index
    customers = Customer.all

    if params[:sort].present? && SORTABLE_ATTRIBUTES.include?(params[:sort].to_sym)
      customers = customers.order(params[:sort].to_sym => :asc)
    end

    if params[:n].present?
      customers = customers.limit(params[:n].to_i)
    end

    if params[:p].present?
      customers = customers.offset((params[:p].to_i - 1) * (params[:n].to_i))
    end

    render json: customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count]),
    status: :ok

  end
  
end
