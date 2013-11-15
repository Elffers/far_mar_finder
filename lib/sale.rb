class Sale
  attr_reader :id, :amount, :purchase_time, :vendor_id, :product_id

  def initialize(array)
    @id             = array[0].to_i
    @amount         = array[1].to_i #in cents
    @purchase_time  = Time.parse(array[2])
    @vendor_id      = array[3].to_i
    @product_id     = array[4].to_i
  end


  def self.all
    @answer ||= CSV.read("./support/sales.csv").map do |array|
      Sale.new(array)
    end
  end

# Finds sale instance that matches argument id
# Returns single sale object 
  def self.find(id)
    all.find do |sale|
      sale.id.to_i == id.to_i
    end
  end

# Returns first sale object associated with vendor with given vendor id "id"
  def self.find_by_vendor_id(id)
    all.find do |sale|
      sale.vendor_id.to_i == id.to_i
    end
  end

# Returns array of sale objects associated with vendor with given vendor id "id"
  def self.find_all_by_vendor_id(id)
    all.find_all do |sale|
      sale.vendor_id == id.to_i
    end
  end

# Return array containing all sales between beginning_time and end_time
  def self.between(beginning_time, end_time)
    start = set_as_time(beginning_time)
    ending = set_as_time(end_time)
    all.find_all do |sale|
      start < sale.purchase_time && sale.purchase_time < ending
    end
  end

# Returns single vendor object associated with given sale instance
  def vendor
    Vendor.all.find do |vendor|
      vendor.id.to_i == @vendor_id.to_i
    end
  end

# Returns single product object associated with given sale instance
  def product
    Product.all.find do |product|
      product.id.to_i == @product_id.to_i
    end
  end

##My own extra methods
#returns collection of products sold on a particular day
  def self.products_on_date(date)
    all.keep_if {|sale| sale.purchase_time.to_date == date.to_date}
  end

### Extra Credit method

# Returns hash with dates as keys and number of sales per date as values
  def self.sales_by_day
    date_hash = {}
    all.each do |sale|
      if date_hash.has_key? sale.purchase_time.to_date
        date_hash[sale.purchase_time.to_date] += 1
      else 
        date_hash[sale.purchase_time.to_date] = 1
      end
    end
    date_hash
  end


# Puts highest number of sales and Returns date with most sales 
  def self.best_day
    puts sales_by_day.values.max
    sales_by_day.key(sales_by_day.values.max).strftime("%m/%d/%Y")
  end

# Returns a hash with vendor id as key and revenue as value
  def self.revenue_by_vendor_id
    hash = {}
    CSV.read("./support/sales.csv").each do |array| 
      hash[array[-2]] ||= 0
      hash[array[-2]] += array[2].to_i
    end
    hash
  end

private

# Returns time argument as a Time object
# Helper function for methods that compare Time objects
  def self.set_as_time(time)
    if time.is_a? String
      Time.parse(time)
    else
     time
    end
  end

end #end class Sale

