class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    if params[:quantity].to_i > 0
      render json: MerchantSerializer.most_items(Merchant.most_items(params[:quantity].to_i))
    else
      render json: { error: { message: 'quantity cant be blank' } }, status: :bad_request
    end
  end
end
