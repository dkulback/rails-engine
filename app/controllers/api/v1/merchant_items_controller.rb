class Api::V1::MerchantItemsController < ApplicationController
  before_action :set_merchant

  def index
    render json: ItemSerializer.new(@merchant.items), status: :ok
  end

  private

  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
