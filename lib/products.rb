class Product

 def self.all
    CSV.read("./support/products.csv").map do |array|
      Market.new()
    end
  end

end
