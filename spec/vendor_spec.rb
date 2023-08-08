require "./lib/item"
require "./lib/vendor"

RSpec.describe Vendor do
  before(:each) do
    @vendor = Vendor.new("Rocky Mountain Fresh")

    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
  end

  describe "#initialize" do
    it "exists" do
      expect(@vendor).to be_a(Vendor)
    end
  end

  describe "#name" do
    it "returns name of the vendor" do
      expect(@vendor.name).to eq("Rocky Mountain Fresh")
    end
  end

  describe "#inventory" do
    it "returns inventory of the vendor" do
      expect(@vendor.inventory).to eq({})
    end
  end

  describe "#check_stock" do
    it "returns the amount of item in stock of a vendor" do
      expect(@vendor.check_stock(@item1)).to eq(0)
    end
  end

  describe "#stock" do
    it "stocks an amount of an item for the vendor" do
      @vendor.stock(@item1, 30)

      expect(@vendor.inventory).to eq({
        @item1 => 30
      })

      expect(@vendor.check_stock(@item1)).to eq(30)

      @vendor.stock(@item1, 25)

      expect(@vendor.check_stock(@item1)).to eq(55)

      @vendor.stock(@item2, 12)

      expect(@vendor.inventory).to eq({
        @item1 => 55,
        @item2 => 12
      })
    end
  end

  describe "#potential_revenue" do
    it "returns the potential revenue of all the items of the vendor" do
      @vendor.stock(@item1, 30)
      @vendor.stock(@item1, 25)
      @vendor.stock(@item2, 12)

      expect(@vendor.potential_revenue).to eq(47.25)
    end
  end
end