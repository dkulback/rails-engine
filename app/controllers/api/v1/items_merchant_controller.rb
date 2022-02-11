class Api::V1::ItemsMerchantController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    render json: MerchantSerializer.single_merchant(@item.merchant), status: :ok if @item
  end
end
