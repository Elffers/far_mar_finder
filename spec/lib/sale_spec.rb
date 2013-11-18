require 'spec_helper'
describe Sale do
  
  let(:finder) { FarMarFinder.new }
  
  if FarMarFinder.new.respond_to? :sales
    let(:sale_class) { finder.sales }
  else
    let(:sale_class) { Sale }
  end
  
  describe "class methods" do

    it "responds to 'all'" do
      sale_class.should respond_to :all
    end
    
    it "'all' should return" do
      sale_class.all.count.should eq 12798
    end
    
    it "responds to 'find'" do
      sale_class.should respond_to :find
    end

    it "responds to find_by_vendor_id" do
      sale_class.should respond_to :find_by_vendor_id
    end

    it "find_by_vendor_id(5) should return" do
      expect(sale_class.find_by_vendor_id(5).id).to eq 22
    end

     it "responds to find_all_by_vendor_id" do
      sale_class.should respond_to :find_all_by_vendor_id
    end

    it "find_all_by_vendor_id(5) should return" do
      expect(sale_class.find_all_by_vendor_id(5).count).to eq 9
    end

    it "responds to products_on_date" do
      sale_class.should respond_to :products_on_date
    end

    it "products_on_date should return" do
      expect(sale_class.products_on_date(Date.new(2013,11,7)).first.id).to eq 1
    end

    it "sale.between should return" do
      sale_class.should_receive(:all).and_return(CSV.read("./support/sales.csv").map { |array|
      Sale.new(array)}.take(10)) # this artificially sets the return as a subset of the original CSV as just the first 10 objects
      sale_class.between(Date.new(2013,11,8), Date.new(2013,11,11)).count.should eq 3
    end
  
  end

  describe "attributes" do
    let(:sale) { sale_class.find(1) }
    # 1,People's Co-op Farmers Sale,30,Portland,Multnomah,Oregon,97202
    
    it "has the id 1" do
      expect(sale.id).to eq 1
    end

    it "has the amount in cents 9290" do
      expect(sale.amount).to eq 9290
    end

    it "has the day 31" do
      expect(sale.purchase_time.day).to eq 7
    end

    it "has the vendor_id 1" do
      expect(sale.vendor_id).to eq 1
    end
    
    it "has the product_id 1" do
      expect(sale.product_id).to eq 1
    end
    
  end
  
  describe "instance methods" do
    let(:sale) { sale_class.find(1) }
    it "responds to vendor" do
      sale.should respond_to :vendor
    end
    
    it "has the vendor" do
      sale.vendor.id.should eq sale.vendor_id
    end
    it "responds to product" do
      sale.should respond_to :product
    end
    it "has the product" do
      sale.product.id.should eq sale.product_id
    end
    
  end
end
