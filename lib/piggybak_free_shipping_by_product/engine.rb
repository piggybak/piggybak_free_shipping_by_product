module PiggybakFreeShippingByProduct
  class Engine < ::Rails::Engine
    config.before_initialize do
      ::Piggybak.config do |config|
        config.shipping_calculators << "::PiggybakFreeShippingByProduct::FreeShippingByProduct"
      end
    end

    config.after_initialize do
      ::Piggybak::OrdersController.send(:include, ::PiggybakFreeShippingByProduct::PiggybakOrdersControllerDecorator)
    end
  end
end
