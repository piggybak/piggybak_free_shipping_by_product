module PiggybakFreeShipping
  class Engine < ::Rails::Engine
    config.before_initialize do
      ::Piggybak.config do |config|
        config.shipping_calculators << "::PiggybakFreeShipping::FreeShippingByProduct"
      end
    end

    config.after_initialize do
      ::Piggybak::OrdersController.send(:include, ::PiggybakFreeShipping::PiggybakOrdersControllerDecorator)
    end
  end
end
