class Sale
  attr_reader :id, :amount, :purchase_time, :vendor_id, :product_id

  def initialize(array)
    @id = array[0]
    @amount = array[1] #in cents
    @purchase_time = array[2]
    @vendor_id = array[3]
    @product_id = array[4]
  end


  def self.all
    CSV.read("./support/sales.csv").map do |array|
      Sale.new(array)
    end
  end

  def self.find(id)
    all.find do |sale|
      sale.id.to_i == id.to_i
    end
  end

  def self.find_by_vendor_id(match)
    all.find do |sale|
      sale.vendor_id.to_i == match.to_i
    end
  end

  def self.find_all_by_vendor_id(match)
    all.find_all do |sale|
      sale.vendor_id == match.to_s
    end
  end

  def vendor
    Vendor.all.find do |vendor|
      vendor.id.to_i == @vendor_id.to_i
    end
  end

  def product
    Product.all.find do |product|
      product.id.to_i == @product_id.to_i
    end
  end

#  - `vendor` - returns the `Vendor` instance that is associated with this sale using the `Sale` `vendor_id` field
# - `product` - returns the `Product` instance that is associated with this sale using the `Sale` `product_id` field
# - `self.between(beginning_time, end_time)` - returns a collection of Sale objects where the purchase time is between the two times given as arguments

end #end class Sale