module Response
  def json_response(object, status = :ok)
    if object[:message].present?
      render json: object, status: status
    else
      render json: MerchantSerializer.single_merchant(object), status: status
    end
  end

  def json_merch_items(object, status = :ok)
    render json: ItemSerializer.new(object), status: status
  end

  def json_item_response(object, status = :ok)
    if object[:message].present?
      render json: object, status: status
    else
      render json: ItemSerializer.single_item(object), status: status
    end
  end
end
