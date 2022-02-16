class Api::V1::RevenueController < ApplicationController
  def index
    if params[:start].present? && params[:end].present?
      revenue = Invoice.sales_over(params[:start], params[:end])
      render json: InvoiceSerializer.total_rev(revenue), status: :ok
    else
      render json: { error: { message: 'dates cant be blank!' } }, status: :bad_request
    end
  end
end
