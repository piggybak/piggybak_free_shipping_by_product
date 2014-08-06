PiggybakFreeShipping
================

### Functionality
* This extension provides free shipping for orders that contain all products indicated as free shipping, via a method or attribute name. Orders that contain all products indicated as free shipping exclude all other shipping methods. Orders that contain at least one product that does not have free shipping offers other available shipping methods based on the Piggybak configuration and shipping calculators.
* Note that if you have multiple product types in your cart, free shipping is only offered for those orders where all items respond\_to? the free shipping method and that value is true.

### Requirements
* This gem requires existing installation of Piggybak. The current version of the gem supports Rails 4, however, additional versions will support Rails 3.

### Installation
* To install, first add gem "piggybak\_free\_shpping\_by\_product" and run bundle install.
* Next, create a product method that you will use to indicate free shipping for a product. This can either be a boolean attribute on your product table, or a more complex method. This code should live in your parent Rails application.
* Next, go to the Piggybak Admin and create a shipping method which uses the Free Shipping By Product calculator. You must create a metadata value to indicate the product method name, e.g. key is "product\_method\_name", and value is your method or attribute. Save this shipping method.
