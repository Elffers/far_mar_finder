class Market
  attr_reader :id, :name, :address, :city, :county, :state, :zip

  def initialize(array)
    @id       = array[0].to_i
    @name     = array[1]
    @address  = array[2]
    @city     = array[3]
    @county   = array[4]
    @state    = array[5]
    @zip      = array[6]
  end

  def self.all
    @answer ||= CSV.read("./support/markets.csv").map do |array|
      Market.new(array)
    end
  end

  def self.find(id)
    all.find do |market|
      market.id.to_i == id.to_i
    end
  end

  def self.find_by_state(match)
    # param = attribute.downcase
    all.find do |market|
      market.state == match.to_s
    end
  end

  # def self.find_by(attribute, match)
  #   param = attribute.to_sym
  #   all.find do |market|
  #     market.param == match.to_s
  #   end
  # end

  def self.find_all_by_state(match)
    all.find_all do |market|
      market.state == match.to_s
    end
  end

  def vendors
    Vendor.all.find_all do |vendor|
      vendor.market_id.to_i == @id.to_i
    end
  end

  #Extra Credit Method
  def products
    products = []
    vendors.each do |vendor|
      products = products + vendor.products
      # products = products + Product.by_vendor(vendor.id)
    end
    products
  end
  # vendors.map {|vendor| vendor.products}.flatten

#returns a collection of Market instances where the market name or vendor(???) name contain the search_term. 
#For example Market.search('school') would return 3 results, one being the market with id 75 (Fox School Farmers Market).
  def self.search(search_term)
    all.keep_if {|market| market.name.to_s.include? search_term.to_s}
  end

  def prefered_vendor
    top_vendor = ''
    array = []
    vendors.each do |vendor|
      array.push vendor.revenue
      if vendor.revenue == array.max
        top_vendor = vendor
      end
    end
    puts array.max
    top_vendor
  # max_revenue = vendors.map {|vendor| vendor.revenue}.max
  # vendors.find_all {|vendor| vendor.revenue == max_revenue}
  end

 



  # def prefered_vendor(date)
  #   vendors.each do |vendor|

  #   end
  # end



  def worst_vendor
    worst_vendor = ''
    array = []
    # vendors.keep_if {|vendor| vendor.revenue}
    vendors.each do |vendor|
      array.push vendor.revenue
      if vendor.revenue == array.min
        worst_vendor = vendor
      end
    end
    puts array.min
    worst_vendor
  end
  
end # end class Market
