require 'spec_helper'

describe Vendor do
  
  let(:finder) { FarMarFinder.new }
  
  if FarMarFinder.new.respond_to? :vendors
    let(:vendor_class) { finder.vendors }
  else
    let(:vendor_class) { Vendor }
  end
  
  describe "class methods" do
    it "responds to 'all'" do
      vendor_class.should respond_to :all
    end
    
    it "'all' should return" do
      vendor_class.all.count.should eq 2690
    end
    
    it "responds to 'find'" do
      vendor_class.should respond_to :find
    end

    it "'find_by_name' should return" do
      vendor_class.find_by_name("Bechtelar Inc").id.should eq "7".to_i
    end
    
    it "responds to 'by_market'" do
      vendor_class.should respond_to :by_market
    end
    
    it "responds to 'find_by_employees" do
      vendor_class.should respond_to :by_no_of_employees
    end

    it "find the first vendor by market 1" do
      vendor_class.by_market(100).first.name.should eq "Schiller-Ledner"
    end
  end
  
  describe "attributes" do
    let(:vendor) { vendor_class.find(10) }
    # 10,Kertzmann LLC,11,3
    
    it "has the id 10" do
      vendor.id.should eq 10
    end
    it "has the name" do
      vendor.name.should eq "Kertzmann LLC"
    end
    it "has the no of employees 11" do
      vendor.no_of_employees.should eq 11
    end
    it "has the market_id 3" do
      vendor.market_id.should eq 3
    end
  end
  
  describe "associations" do
    let(:vendor) { vendor_class.find(1) }

    it "responds to :market" do
      vendor.should respond_to :market
    end
    
    it "market_id matches the markets id" do
      vendor.market.id.should eq vendor.market_id
    end
    
    it "responds to :sales" do
      vendor.should respond_to :sales
    end
    
    it "has 7 sales" do
      vendor.sales.count.should eq 7
    end
    
    it "responds to products" do
      vendor.should respond_to :products
    end
    
    it "has 1 products" do
      vendor.products.count.should eq 1
    end
  end
  
end