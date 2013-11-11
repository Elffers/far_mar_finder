class Sale

   def self.all
    CSV.read("./support/sales.csv").map do |array|
      Market.new()
    end
  end
end