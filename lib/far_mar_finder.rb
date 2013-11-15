require 'csv'
require 'time'
require './lib/market' # originally require_relative 'market', which obviates the need to hard code the file path name
require_relative 'products'
require_relative 'vendor'
require_relative 'sale'



class FarMarFinder
  
  def markets
    Market.inspect
  end
  
  def vendors
    Vendor.inspect
  end

  def products
    Product.inspect
  end

  def sales
    Sale.inspect
  end

### Extra credit method

# Returns random instance
  def random
    far_mar = Market.all + Vendor.all + Product.all + Sale.all
    far_mar.sample
  end

  
end #end FarMarFinder


