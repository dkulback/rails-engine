class Api::V1::MerchantItemsController < ApplicationController
  before_action :set_merchant
  def index
    json_merch_items(@merchant.items)
  end

  private

  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
