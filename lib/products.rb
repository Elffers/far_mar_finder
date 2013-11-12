class Product
attr_reader :id, :name, :vendor_id

def initialize(array)
  @id = array[0]
  @name = array [1]
  @vendor_id = array[2]
end

 def self.all
    CSV.read("./support/products.csv").map do |array|
      Market.new(array)
    end
  end

 

end
