require 'spec_helper'
describe Market do
  
  let(:finder) { FarMarFinder.new }
  
  if FarMarFinder.new.respond_to? :markets
    let(:market_class) { finder.markets }
  else
    let(:market_class) { Market }
  end
  
  describe "class methods" do
    it "responds to 'all'" do
      market_class.should respond_to :all
    end
    
    it "'all' should return" do
      market_class.all.count.should eq 500
    end
    
    it "responds to 'find'" do
      market_class.should respond_to :find
    end

    it "find_by_state" do
      market_class.find_by_state("New York").zip.should eq "13329"
    end

    it "'find_all_by_state' should return" do
      market_class.find_all_by_state("Oregon").first.name.should eq "People's Co-op Farmers Market"
    end

    it "'search' should return" do
      market_class.search("Otsiningo Park").first.zip.should eq "13905"
    end

  end
  
  describe "attributes" do
    let(:market) { market_class.find(1) }
    # 1,People's Co-op Farmers Market,30,Portland,Multnomah,Oregon,97202
    
    it "has the id 1" do
      expect(market.id).to eq 1
    end

    it "has the name 'People's Co-op Farmers Market'" do
      expect(market.name).to eq "People's Co-op Farmers Market"
    end

    it "has the address '30th and Burnside'" do
      expect(market.address).to eq "30th and Burnside"
    end

    it "has the city 'Portland'" do
      expect(market.city).to eq "Portland"
    end
    it "has the county 'Multnomah'" do
      expect(market.county).to eq "Multnomah"
    end
    it "has the state 'Oregon'" do
      expect(market.state).to eq "Oregon"
    end
    it "has the zip '97202'" do
      expect(market.zip).to eq "97202"
    end
    
  end
  
  describe "instance methods" do
    let(:market) { market_class.find(1) }
    it "responds to vendors" do
      Market.new({}).should respond_to :vendors
    end
    
    it "finds the vendors" do
      market.vendors.first.id.should eq 1
    end
    
    # My specs
    it "responds to products" do
      Market.new({}).should respond_to :products
    end

    it "finds the products name" do
      market.products.first.name.should eq "Dry Beets"
    end
  
  end

end
