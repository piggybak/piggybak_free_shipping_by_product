require 'test_helper'

class PiggybakFreeShippingTest < ActionDispatch::IntegrationTest
  fixtures :images,
    :piggybak_sellables,
    :piggybak_shipping_methods,
    :piggybak_shipping_method_values,
    :piggybak_payment_methods,
    :piggybak_orders

  def setup_order
    post_via_redirect piggybak.cart_add_path, { sellable_id: 1, quantity: 1 }
    get_via_redirect piggybak.orders_path
  end

  def order_params
    { "order" => {
       "email" => "test@endpoint.com",
       "phone" => "6304844834",
       "billing_address_attributes" => {
         "firstname"=>"S",
         "lastname"=>"S",
         "address1"=>"123",
         "address2"=>"",
         "city"=>"SLC",
         "country_id"=>"405",
         "state_id"=>"6926",
         "zip"=>"84115"
       },
       "shipping_address_attributes" => {
         "firstname" => "S",
         "lastname"=>"S",
         "address1"=>"123",
         "address2"=>"",
         "city"=>"SLC",
         "country_id"=>"405",
         "state_id"=>"6926",
         "zip"=>"84115" },
       "line_items_attributes" => {
         "0" => {
           "line_item_type" => "shipment",
           "shipment_attributes" => {
             "shipping_method_id"=>"4"
           }
         },
         "1" => {
           "line_item_type" => "payment",
           "payment_attributes" => {
             "number" => "4111111111111111",
             "verification_value"=>"333",
             "month"=>"1",
             "year"=>"2016"
           }
         }
       }
     }
    }
  end 

  test "cart with free shpping item has free shipping as only option" do
    cookies["cart"] = "1:1"
    xhr :get, piggybak.orders_shipping_path
    methods = JSON.parse(response.body)
    assert methods == [{"label" => "Free Shipping $0.00", "id" => 3, "rate" => 0.0 }]
  end
  test "cart with non-free shpping item has regular shipping options" do
    cookies["cart"] = "2:1"
    xhr :get, piggybak.orders_shipping_path
    methods = JSON.parse(response.body)
    assert methods.size == 2
    assert methods.include?({ "label" => "Standard Shipping $10.00", "id" => 1, "rate" => 10.0 })
    assert methods.include?({ "label" => "Express Shipping $20.00", "id" => 2, "rate" => 20.0 })
    assert !methods.include?({ "label" => "Free Shipping $0.00", "id" => 3, "rate" => 0.0 })
  end
  test "cart with mixed items regular shipping options" do
    cookies["cart"] = "1:1;2:1"
    xhr :get, piggybak.orders_shipping_path
    methods = JSON.parse(response.body)
    assert methods.size == 2
    assert methods.include?({ "label" => "Standard Shipping $10.00", "id" => 1, "rate" => 10.0 })
    assert methods.include?({ "label" => "Express Shipping $20.00", "id" => 2, "rate" => 20.0 })
    assert !methods.include?({ "label" => "Free Shipping $0.00", "id" => 3, "rate" => 0.0 })
  end
end
