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

### Extra credit methods

#Returns an array containing revenue for each vendor
  def self.vendor_revenues
    @vendor_revenues ||= all.map do |vendor|
      vendor.revenue
    end
  end

## *** Apply Sale.revenue_by_vendor_id method ***
# Array -> hash
# Returns hash containing top n Vendors with highest revenues, with vendor objects as keys and their respective revenues as the values
  def self.most_revenue(n)
    vendor_hash = {}
    all.each { |vendor| vendor_hash[vendor] = vendor.revenue}
    ## The following method assumes uniqueness between vendors and revenue values
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

# ** Very slow--apply Sale.revenue_by_vendor_id method or similar?
# ** More than 10 vendors for top sale number (18)
# Returns hash of top n vendors with sales as key and array of vendors as values
  def self.most_items(n)
    vendor_hash = {}
    all.each {|vendor| vendor_hash[vendor] = vendor.sales.length}
    top_vendors = {}
    sale_array = []
    vendor_hash.values.sort.reverse.take(n).each do |sale|
      if sale_array.include? sale
        top_vendors[sale].push vendor_hash.key(sale)
      else
        top_vendors[sale] = [vendor_hash.key(sale)]
        sale_array.push sale
      end
    end
    top_vendors
  end

# Returns the number of sales on given date 
  def self.revenue(date)
    day = set_as_date(date)
    Sale.sales_by_day[day]
  end

# Returns Fixnum of revenue for that vendor across the range of dates from beginning_time to end_time
  def revenue(beginning_time, end_time)
    amount = 0
    Sale.between(beginning_time, end_time).each do |sale|  
      if sale.vendor_id == id
        amount += sale.amount
      end
    end
    amount
  end

# Returns Fixnum of total revenue on date
## Should separate code in revenue method?
  def revenue(date)
    day = set_as_date(date)
    revenue = 0
    sales.map do |sale|
      if sale.purchase_time.to_date == day
        revenue += sale.amount
      end
    end
    revenue
  end

private 

def self.set_as_date(date)
  if date.is_a? String
    Date.parse(date)
  else
    date
  end
end

end #end of Vendor class

###self.most_items(n) returns the top n vendor instances ranked by total number of items sold
### self.revenue(date) returns the total revenue for that date across all vendors
# revenue(range_of_dates) returns the total revenue for that vendor across several dates
# revenue(date) returns the total revenue for that specific purchase date


  
# end