require 'test_helper'

class PiggybakFreeShippingTest < ActionDispatch::IntegrationTest
  fixtures :images, :piggybak_sellables

  def setup_order
    post_via_redirect piggybak.cart_add_path, { sellable_id: 1, quantity: 1 }
    get_via_redirect piggybak.orders_path
  end

  test "order with free shpping item has free shipping as only option" do
    setup_order

puts "stephie: #{Image.all.inspect}"
=begin
    p = order_params
    p["order"]["line_items_attributes"]["0"]["shipment_attributes"]["shipping_method_id"] = "5"
    post_via_redirect piggybak.orders_path, p, { "User-Agent" => "Testbot" }

    # Assert tax value is correct
    order = assigns(:order)
    assert_not_nil order
    assert order.total = 59.98
    shipping = order.line_items.detect { |li| li.line_item_type == "shipment" }
    assert_not_nil shipping
    assert shipping.price == 20.00
=end
  end

=begin
  test "order with free shipping item and another item has regular shipping options" do
    setup_order
  end

  test "order with non-free shipping items has regular shipping options" do
    setup_order
  end
=end

end
