class Api::V1::Merchants::SearchController < ApplicationController
  def show
    if !params[:name].blank?
      merchant = Merchant.search(params[:name])
      if merchant.nil?
        render json: {
          data: { message: 'Unable to find Merchant' }
        }, status: 404
      else
        render json: MerchantSerializer.new(merchant), status: :ok
      end
    else
      render json: { error: { message: "Search field can't be blank'" } }, status: :bad_request
    end
  end
end
