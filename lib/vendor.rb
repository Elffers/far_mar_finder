class Vendor
  attr_reader :id, :name, :no_of_employees, :market_id

  def initialize(array)
    @id             = array[0].to_i
    @name           = array[1]
    @no_of_employees = array[2].to_i
    @market_id      = array[3].to_i
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

  def self.by_market(id)
    all.find_all do |vendor|
      vendor.market_id == id.to_i
    end
  end
  
  
  def self.by_no_of_employees(match)
    all.find_all do |vendor|
      vendor.no_of_employees == match.to_i
    end
  end

  def market
    Market.all.find do |market|
      market.id.to_i == @market_id.to_i
    end
  end
  
  def products
    Product.all.find_all do |product|
      product.vendor_id.to_i == @id.to_i
    end
  end

  def sales 
    Sale.all.find_all do |sale|
      sale.vendor_id.to_i == @id.to_i
    end
  end
  
  def revenue
    sum = 0
    sales.each do |sale|
      sum = sum + sale.amount.to_i
    end
    sum
  end

end #end of Vendor class

