class Vendor
  attr_reader :id, :name, :no_of_employees, :market_id

  def initialize(array)
    @id             = array[0].to_i
    @name           = array[1]
    @no_of_employees = array[2].to_i
    @market_id      = array[3].to_i
  end

# Returns Array of vendor objects
  def self.all
    @answer ||= CSV.read("./support/vendors.csv").map do |array|
      Vendor.new(array)
    end
  end

# Returns vendor object associated with id 
  def self.find(id)
    all.find do |vendor|
      vendor.id.to_i == id.to_i
    end
  end

# Returns vendor object associated with name
  def self.find_by_name(name)
    all.find do |vendor|
      vendor.name == name.to_s
    end
  end

# Returns Array containing vendor objects associated with market with id "id"
  def self.by_market(id)
    all.find_all do |vendor|
      vendor.market_id == id.to_i
    end
  end
  
# Returns Array containing all vendor objects with number of employees "number"
  def self.by_no_of_employees(number)
    all.find_all do |vendor|
      vendor.no_of_employees == number.to_i
    end
  end

# Returns single market object associated with vendor instance
  def market
    Market.all.find do |market|
      market.id.to_i == @market_id.to_i
    end
  end
  
# Returns Array containing product objects associated with vendor instance
  def products
    Product.all.find_all do |product|
      product.vendor_id.to_i == @id.to_i
    end
  end

# Returns Array of sale objects associated with vendor instance
  def sales 
    Sale.all.find_all do |sale|
      sale.vendor_id.to_i == @id.to_i
    end
  end
  
# Returns Fixnum of sum of all vendor instance's sales (in cents)
# If beginning_time and end_time are passed in, all sales between dates
  def revenue(beginning_time=nil, end_time=nil)
    start = Vendor.set_as_date(beginning_time)
    ending = Vendor.set_as_date(end_time)

    if !beginning_time && !end_time
      Sale.revenue_by_vendor_id[@id]
    elsif beginning_time && !end_time 
      Sale.revenue_by_date_and_vendor_id(start)[@id]
    else
      revenue = 0
      date_range = (start..ending)
      date_range.each do |date|
        revenue += Sale.revenue_by_date_and_vendor_id(date)[@id].to_i
      end
      revenue
    end
  end

### Extra credit methods

# Returns hash containing top n Vendors with highest revenues, with vendor objects as keys and their respective revenues as the values
  def self.most_revenue(n)
    top_revenues = Sale.revenue_by_vendor_id.values.sort.reverse.take(n)
    vendor_ids = top_revenues.map {|revenue| Sale.revenue_by_vendor_id.key(revenue)}
    puts top_revenues
    vendor_ids.map {|id| Vendor.find(id)}
  end

# ** More than 10 vendors for top sale number (18)
# Returns hash of top n vendors with sales as key and array of vendors as values
  def self.most_items(n)
    top_sales = Sale.sales_by_vendor_id.values.sort.reverse.take(n)
    vendor_ids = top_sales.map {|sale| Sale.sales_by_vendor_id.key(sale)}
    puts top_sales
    vendor_ids.map {|id| Vendor.find(id)}
  end

# Returns Fixnum of number of sales on given date 
  def self.revenue(date)
    day = set_as_date(date)
    Sale.sales_by_day[day]
  end

private 
# Returns date as Date object; helper function for methods requiring dates
  def self.set_as_date(date)
    if date.is_a? String
      Date.parse(date)
    elsif date.is_a? Time 
      date.to_date
    else
      date
    end
  end

end #end of Vendor class