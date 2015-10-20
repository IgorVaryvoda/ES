module PaypalHelper
  def get_setup_purchase_params(order, request)
    return to_cents(order.price), {
        :ip => request.remote_ip,
        :return_url => get_token_url(order),
        :cancel_return_url => root_url,
        :currency => "USD",
        :allow_guest_checkout => true,
        :items => [get_item(order)]
    }
  end

  def to_cents(money)
    (money*100).round
  end

  def get_item(order)
    return {
        :name => order.topic,
        :description => order.details,
        :quantity => 1,
        :amount => to_cents(order.price)
    }
  end
end
