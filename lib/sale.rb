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

  def self.between(beginning_time, end_time)
    all.find_all do |sale|
      beginning_time < Time.parse(sale.purchase_time) && Time.parse(sale.purchase_time) < end_time
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

end #end class Sale