class Vendor
  attr_reader :id, :name, :no_of_employees, :market_id

  def initialize(array)
    @id             = array[0].to_i
    @name           = array[1]
    @no_of_employees = array[2].to_i
    @market_id      = array[3].to_i
  end

  # returns all rows of the CSV file as objects of an array 
  def self.all
    @answer ||= CSV.read("./support/vendors.csv").map do |array|
      Vendor.new(array)
    end
  end

  # returns the row of the CSV where the ID field matches the argument
  def self.find(id)
    all.find do |vendor|
      vendor.id.to_i == id.to_i
    end
  end


  def self.find_by_name(name)
    all.find do |vendor|
      vendor.name == name.to_s
    end
  end

  def self.by_market(id)
    all.find_all do |vendor|
      vendor.market_id == id.to_i
    end
  end
  
  
  def self.by_no_of_employees(number)
    all.find_all do |vendor|
      vendor.no_of_employees == number.to_i
    end
  end

  # returns the `Market` instance that is associated with a vendor instance using the `Vendor` `market_id` field
  def market
    Market.all.find do |market|
      market.id.to_i == @market_id.to_i
    end
  end
  
  # returns a collection of `Product` instances that are associated with a vendor instance by the `Product` `vendor_id` field.
  def products
    Product.all.find_all do |product|
      product.vendor_id.to_i == @id.to_i
    end
  end

  # returns a collection of `Sale` instances that are associated with a vendor instance by the `vendor_id` field.
  def sales 
    Sale.all.find_all do |sale|
      sale.vendor_id.to_i == @id.to_i
    end
  end
  
  # returns the the sum of all a vendor instance's sales (in cents)
  def revenue
    sum = 0
    sales.each do |sale|
      sum = sum + sale.amount.to_i
    end
    sum
  end

# Extra credit method
  def self.vendor_revenues
    @vendor_revenues ||= all.map do |vendor|
      vendor.revenue
    end
  end

  def self.most_revenue(n)
  # # returns the top n vendor instances ranked by total revenue
  #   index_array = vendor_revenues.sort.reverse.take(n).map do |revenue|
  #     @vendor_revenues.index(revenue)
  #   end
  #   puts @vendor_revenues.sort.reverse.take(n)
  #   index_array.map do |index|
  #     all[index] 
  #   end
  # end
    vendor_hash = {}
    all.each do |vendor|
      vendor_hash[vendor] = vendor.revenue
    end
    # vendor_hash.values.sort.reverse.take(n).map do |revenue|
    #   vendor_hash.key(revenue)
    # end
    top_vendors = {}
    revenue_array = []
    vendor_hash.values.sort.reverse.take(n).each do |revenue|
      if revenue_array.include? revenue
        top_vendors[revenue].push vendor_hash.key(revenue)
      else
        top_vendors[revenue] = [vendor_hash.key(revenue)]
        revenue_array.push revenue
      end
    end
    top_vendors
  end
   

end #end of Vendor class

=begin


- `self.find_by_x(match)` - where X is an attribute, returns a single instance whose X attribute case-insensitive attribute matches the match parameter. For instance, Vendor.find_by_name("windler inc") could find a Vendor with the name attribute "windler inc" or "Windler Inc".
- `self.find_all_by_x(match)` - works just like `find_by_x` but returns a collection containing all possible matches. For example `Market.find_by_state("WA")` could return all of the Market object with `"WA"` in their state field.


- `
- `revenue` - 
- `self.by_market(market_it)` - returns all of the vendors with the given `market_id`
- `prefered_vendor` - returns the vendor with the highest revenue
- `prefered_vendor(date)` - returns the vendor with the highest revenue for the given date
- `worst_vendor` - returns the vendor with the lowest revenue
- `worst_vendor(date)` - returns the vendor with the lowest revenue by date
  
end