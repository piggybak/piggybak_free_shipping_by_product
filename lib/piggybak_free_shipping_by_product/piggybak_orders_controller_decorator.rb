module PiggybakFreeShippingByProduct
  module PiggybakOrdersControllerDecorator
    extend ActiveSupport::Concern

    included do
      alias :piggybak_shipping :shipping
      def shipping; custom_shipping; end
    end

    def custom_shipping
      cart = Piggybak::Cart.new(request.cookies["cart"])
      cart.set_extra_data(params)
      shipping_methods = Piggybak::ShippingMethod.lookup_methods(cart)
      
      free_shipping_method = Piggybak::ShippingMethod.all.detect { |s| s.klass == "::PiggybakFreeShippingByProduct::FreeShippingByProduct" }
      if free_shipping_method.present?
        free_shipping_available = shipping_methods.detect { |s| s[:id] == free_shipping_method.id }
        if free_shipping_available.present?
          render :json => [free_shipping_available]
          return 
        end
      end

      render :json => shipping_methods
    end
  end
end
