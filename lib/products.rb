class Product
attr_reader :id, :name, :vendor_id

  def initialize(array)
    @id         = array[0].to_i 
    @name       = array [1]
    @vendor_id  = array[2].to_i
  end

  def self.all
    @answer ||= CSV.read("./support/products.csv").map do |array|
      Product.new(array)
    end
  end

# Returns product object associated with "id"  
  def self.find(id)
    all.find do |product|
      product.id.to_i == id.to_i
    end
  end

# Returns product object associated with "name"
  def self.find_by_name(name)
    all.find do |product|
      product.name.to_s == name.to_s
    end
  end

# Returns Array containing all product objects associated with vendor with "vendor_id"
  def self.by_vendor(vendor_id)
    all.find_all do |product|
      product.vendor_id.to_i == vendor_id.to_i
    end
  end

# Returns vendor object associated with given product instance
  def vendor
    Vendor.all.find do |vendor|
      vendor.id.to_i == @vendor_id.to_i
    end
  end
  
# Returns array of all sale objects for a given product
  def sales 
    Sale.all.find_all do |sale|
      sale.product_id.to_i == @id.to_i
    end
  end

# Returns FixNum of total number of sales (transactions) for given product
  def number_of_sales
    sales.count
  end

### My own methods
# Returns Array containing all date objects on which the given product was sold
  def date
    sale_array = Sale.all.keep_if {|sale| sale.product_id.to_i == @id.to_i}
    sale_array.map {|sale| sale.purchase_time.to_date}
  end

# Returns Fixnum of total revenue for given product instance
def revenue
    sum = 0
    sales.each do |sale|
      sum += sale.amount
    end
    sum
  end

### Extra credit methods
# Returns date object associated with highest number of sales
# Puts the number of sales
  def best_day
    date_hash = {}
    date.each do |date|
      if date_hash.has_key? date
        date_hash[date] += 1
      else 
        date_hash[date] = 1
      end
    end
    puts date_hash.values.max
    day = date_hash.key(date_hash.values.max)
    return day.strftime("%m/%d/%Y")
  end

# Returns array of total revenue per product
# Helper method for self.most_revenue(n) method
  def self.product_revenues
    @product_revenues ||= all.map do |product|
      product.revenue
    end
  end

# Returns Array of top n products ranked by total revenue
  def self.most_revenue(n) 
    index_array = product_revenues.sort.reverse.take(n).map do|revenue|
      @product_revenues.index(revenue)
    end
    puts product_revenues.sort.reverse.take(n)
    index_array.map do |index|
      all[index]
    end
  end


end #end of Product class

