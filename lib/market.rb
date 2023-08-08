class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.inventory.include?(item)
    end
  end

  def sorted_item_list
    @vendors.map do |vendor|
      vendor.inventory.map do |item|
        item[0].name
      end
    end.flatten.uniq.sort
  end

  def total_inventory
    inventory_hash = {}
    
    @vendors.each do |vendor|
      vendor.inventory.each do |item|
        inventory_hash[item[0]] = {quantity: 0, vendors: []}
      end
    end
    @vendors.each do |vendor|
      vendor.inventory.each do |item|
        inventory_hash[item[0]][:quantity] += item[1]
        inventory_hash[item[0]][:vendors] << vendor
      end
    end
    inventory_hash
  end

  def overstocked_items
    items = []

    total_inventory.each do |item, values|
      if values[:quantity] > 50 && values[:vendors].count > 1
        items << item
      end
    end
    items
  end
end