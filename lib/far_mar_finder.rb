require 'csv'
require 'time'
require './lib/market' # originally require_relative 'market', which obviates the need to hard code the file path name
require_relative 'products'
require_relative 'vendor'
require_relative 'sale'



class FarMarFinder
  
  def markets
    Market.all.first.class
  end
  
  def vendors
    Vendor.all.first.class
  end

  def products
    Product.all.first.class
  end

  def sales
    Sale.all.first.class
  end
  
end #end FarMarFinder

# finder = FarMarFinder.new
# finder.markets
#  #=> Market
# finder.vendors
#  #=> Vendor
# finder.products
#  #=> Product
# finder.sales
#  #=> Sale
# We will build class methods on the returned class Object

# finder = FarMarFinder.new
# finder.markets.all
#  # => [...] Returns all instances of the Market class


