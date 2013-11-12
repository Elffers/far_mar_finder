class Vendor
  attr_reader :id, :name, :num_employees, :market_id

  def initialize(array)
    @id             = array[0]
    @name           = array[1]
    @num_employees  = array[2]
    @market_id      = array[3]
  end

  def self.all
    CSV.read("./support/vendors.csv").map do |array|
      Vendor.new(array)
    end
  end

  def self.find(id)
    all.find do |vendor|
      vendor.id.to_i == id.to_i
    end
  end

#where X is an attribute, returns a single instance whose X attribute 
#case-insensitive attribute matches the match parameter. For instance, 
#Vendor.find_by_name("windler inc") could find a Vendor with the name attribute "windler inc" or "Windler Inc".

  def self.find_by_name(match)
    all.find do |vendor|
      vendor.name == match.to_s
    end
  end
  
  def self.find_all_by_num_employees(match)
    all.find_all do |vendor|
      vendor.num_employees == match.to_s
    end
  end

  def market
    Market.all.find do |market|
      market.id.to_i == @market_id.to_i
    end
  end


# **Additional Market Methods**
    
# - `vendors` - returns a collection of `Vendor` instances that are associated with the market by the market_id field.

# **Additional Vendor Methods**

# - `market` - returns the `Market` instance that is associated with this vendor using the `Vendor` `market_id` field
# - `products` - returns a collection of `Product` instances that are associated with market by the `Product` `vendor_id` field.
# - `sales` - returns a collection of `Sale` instances that are associated with market by the `vendor_id` field.
# - `revenue` - returns the the sum of all of the vendor's sales (in cents)

end
