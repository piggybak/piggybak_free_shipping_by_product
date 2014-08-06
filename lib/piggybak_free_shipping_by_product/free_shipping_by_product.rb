module PiggybakFreeShippingByProduct
  class FreeShippingByProduct
    # This assumes that your product has a method defined by your configuration
    KEYS = ["product_method_name"]

    def self.description
      "Free Shipping by Product"
    end 

    def self.available?(method, object)
      product_method = method.metadata.detect { |m| m.key == "product_method_name" }.value

      if object.is_a?(Piggybak::Cart)
        return object.sellables.all? { |s| s[:sellable].item.respond_to?(product_method) && s[:sellable].item.send(product_method) }
      else
        return object.line_items.sellables.all? { |s| s.sellable.item.respond_to?(product_method) && s.sellable.item.send(product_method) }
      end
      return false
    end

    def self.rate(method, object)
      0.00
    end
  end
end
