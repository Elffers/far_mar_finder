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
    CSV.read("./support/markets.csv").map do |array|
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

end # end class Market
