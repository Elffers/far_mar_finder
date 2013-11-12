class Market
  attr_reader :id, :name, :address, :city, :county, :state, :zip

  def initialize(array)
    @id       = array[0]
    @name     = array[1]
    @address  = array[2]
    @city     = array[3]
    @county   = array[4]
    @state    = array[5]
    @zip      = array[6]
  end

#`self.all` - returns all rows of the CSV file as objects
  def self.all
    CSV.read("./support/markets.csv").map do |array|
      Market.new(array)
    end
  end

#returns the row where the ID field matches the argument
  def self.find(id)
    all.find do |market|
      market.id.to_i == id.to_i
    end
  end

#where X is an attribute, returns a single instance whose X attribute 
#case-insensitive attribute matches the match parameter. For instance, 
#Vendor.find_by_name("windler inc") could find a Vendor with the name attribute "windler inc" or "Windler Inc".
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

#works just like `find_by_x` but returns a collection containing all possible matches. 
#For example `Market.find_by_state("WA")` could return all of the Market object with `"WA"` in their state field.
  def self.find_all_by_state(match)
    all.find_all do |market|
      market.state == match.to_s
    end
  end

#returns a collection of `Vendor` instances that are associated with the market by the market_id field.
  def vendors

  end

end # end class Market
