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

  def self.find(id)
    all.find do |product|
      product.id.to_i == id.to_i
    end
  end


  def self.find_by_name(name)
    all.find do |product|
      product.name.to_s == name.to_s
    end
  end

  def self.by_vendor(vendor_id)
    all.find_all do |product|
      product.vendor_id.to_i == vendor_id.to_i
    end
  end

  def vendor
    Vendor.all.find do |vendor|
      vendor.id.to_i == @vendor_id.to_i
    end
  end

  
  #Returns array of all sale objects for a given product
  def sales 
    Sale.all.find_all do |sale|
      sale.product_id.to_i == @id.to_i
    end
  end

  def number_of_sales
    sales.count
  end

# My own methods
## returns all dates the product was sold on
  def date
    sale_array = Sale.all.keep_if {|sale| sale.product_id.to_i == @id.to_i}
    sale_array.map {|sale| sale.purchase_time.to_date}
  end

  def revenue
    sum = 0
    sales.each do |sale|
      sum += sale.amount
    end
    sum
  end


#Extra credit method
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
    date_hash.key(date_hash.values.max)
  end

#Returns top n products ranked by total revenue
  def self.product_revenues
    @product_array ||= all.map do |product|
      product.revenue
    end
  end

  def self.most_revenue(n)
    index_array = product_revenues.sort.reverse.take(n).map do|revenue|
      @product_array.index(revenue)
    end
    puts product_revenues.sort.reverse.take(n)
    index_array.map do |index|
      all[index]
    end
  end


end #end of Product class

