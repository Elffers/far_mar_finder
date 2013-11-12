class Product
attr_reader :id, :name, :vendor_id

  def initialize(array)
    @id         = array[0].to_i 
    @name       = array [1]
    @vendor_id  = array[2].to_i
  end

  def self.all
    CSV.read("./support/products.csv").map do |array|
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

  def self.find_by_vendor(vendor_id)
    all.find do |product|
      product.vendor_id.to_i == vendor_id.to_i
    end
  end

  def vendor
    Vendor.all.find do |vendor|
      vendor.id.to_i == @id.to_i
    end
  end

  def sales 
    Sale.all.find do |sale|
      sale.id.to_i == @id.to_i
    end
  end

  def number_of_sales
    sales.amount
  end

end #end of Product class

