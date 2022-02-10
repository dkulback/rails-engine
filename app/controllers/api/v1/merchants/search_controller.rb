class Api::V1::Merchants::SearchController < ApplicationController
  def show
    merchant = Merchant.search(params[:name])
    if merchant.nil?
      render json: {
        data: { message: 'Unable to find Merchant' }
      }, status: 404
    else
      render json: MerchantSerializer.single_merchant(merchant), status: :ok
    end
  end
end
