class Vendor

   def self.all
    CSV.read("./support/vendors.csv").map do |array|
      Market.new()
    end
  end
end
