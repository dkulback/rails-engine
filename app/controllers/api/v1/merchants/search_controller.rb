class Api::V1::Merchants::SearchController < ApplicationController
  def show
    merchant = Merchant.search(params[:name])
    if merchant.nil?
      render json: {
        data: { message: 'Unable to find Merchant' }
      }, status: 404
    else
      json_response(merchant)
    end
  end
end
