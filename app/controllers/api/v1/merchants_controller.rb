class Api::V1::MerchantsController < ApplicationController
  before_action :set_merchant, only: [:show]
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    json_response(@merchant)
  end

  private

  def set_merchant
    @merchant = Merchant.find(params[:id])
  end
end
