class Api::V1::MerchantsController < ApplicationController
  before_action :set_merchant, only: [:show]
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    json_response(@merchant)
  end

  def find
    merchant = Merchant.search(params[:name])
    if merchant.nil?
      render json: {
        data: { message: 'Unable to find Merchant' }
      }, status: 404
    else
      json_response(merchant)
    end
  end

  private

  def set_merchant
    @merchant = Merchant.find(params[:id])
  end
end
