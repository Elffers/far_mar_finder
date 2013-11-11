class Market
  attr_reader :name, :address, :city, :county, :state, :zip

  def initialize(array)
    @name = array[1]
  end

  def self.all
    CSV.read("./support/markets.csv").map do |array|
      Market.new()
    end
  end

end
