# frozen_string_literal: true

require_relative 'item'

class GildedRose
  SPECIAL_ITEMS = [
    'Aged Brie', 
    'Backstage passes to a TAFKAL80ETC concert', 
    'Sulfuras, Hand of Ragnaros', 
    'Conjured Mana Cake'
  ]

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      normal_item_quality(item) unless SPECIAL_ITEMS.include?(item.name)
      brie_quality(item) if item.name == SPECIAL_ITEMS[0]
      backstage_pass_quality(item) if item.name == SPECIAL_ITEMS[1]
      conjured_item_quality(item) if item.name == SPECIAL_ITEMS[3]
      update_sell_in(item)
    end
  end

  ITEMS = { 
    "Elixir of the Mongoose" => NormalItem, 
    'Sulfuras, Hand of Ragnaros' => LegendaryItem,
    'Aged Brie' => CheeseItem
  }

  def sort_items
    @items.map! do |item|
      item = ITEMS[item.name].new(name = item.name, sell_in = item.sell_in, quality = item.quality)
    end
  end

  def update_sell_in(item)
    return if item.name == 'Sulfuras, Hand of Ragnaros'

    item.sell_in -= 1
  end

  def backstage_pass_quality(item)
    return item.quality = 0 if out_of_date?(item)

    item.quality += 1 if !max_quality?(item) && item.sell_in < 6
    item.quality += 1 if !max_quality?(item) && item.sell_in < 11
    item.quality += 1 if !max_quality?(item)
  end

  def brie_quality(item)
    item.quality += 1 if !max_quality?(item)
    item.quality += 1 if !max_quality?(item) && out_of_date?(item)
  end

  def normal_item_quality(item)
    item.quality -= 1 if !min_quality?(item)
    item.quality -= 1 if !min_quality?(item) && out_of_date?(item) 
  end

  def conjured_item_quality(item)
    item.quality -= 2 if !min_quality?(item)
    item.quality -= 2 if !min_quality?(item) && out_of_date?(item) 
  end

  private

  def max_quality?(item)
    item.quality == 50
  end
  
  def min_quality?(item)
    item.quality == 0
  end

  def out_of_date?(item)
    item.sell_in <= 0
  end

end
