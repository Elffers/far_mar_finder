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

# Returns single market object associated with market "id"
  def self.find(id)
    all.find do |market|
      market.id.to_i == id.to_i
    end
  end

# Returns first instance of market object associated with "state"
  def self.find_by_state(state)
    all.find do |market|
      market.state == state.to_s
    end
  end

  # def self.find_by(attribute, match)
  #   param = attribute.to_sym
  #   all.find do |market|
  #     market.param == match.to_s
  #   end
  # end

# Returns Array containing all market objects associated with "state"
  def self.find_all_by_state(state)
    all.find_all do |market|
      market.state == state.to_s
    end
  end

# Returns Array containing all vendor objects associated with given market
  def vendors
    Vendor.all.find_all do |vendor|
      vendor.market_id.to_i == @id.to_i
    end
  end

  ### Extra Credit Methods ###

# Returns Array containing all product objects associated with all vendors associated with given market
  def products
    products = []
    vendors.each do |vendor|
      products += vendor.products
    end
    products
  end
  # vendors.map {|vendor| vendor.products}.flatten

# Returns Array containing all market objects whose name contains search_term
  def self.search(search_term)
    all.keep_if {|market| market.name.to_s.include? search_term.to_s}
  end

# Returns vendor object with the higheset revenue for given market
# Puts revenue associated with top vendor 
  def prefered_vendor
    # @date = options[:date] || #sale.purchase_time
    top_vendor = ''
    array = []
    vendors.map do |vendor|
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

# Returns vendor object with the lowest revenue for given market
# Puts revenue associated with worst vendor 
  def worst_vendor
    min_revenue = vendors.map {|vendor| vendor.revenue}.min
    puts min_revenue
    vendors.find_all{|vendor| vendor.revenue == min_revenue}
  end
  
end # end class Market
