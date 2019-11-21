# frozen_string_literal: true

require_relative 'item'

class GildedRose

  SPECIAL_ITEMS = { 
    "Elixir of the Mongoose" => NormalItem, 
    'Sulfuras, Hand of Ragnaros' => LegendaryItem,
    'Aged Brie' => CheeseItem,
    'Backstage passes to a TAFKAL80ETC concert' => BackstagePassItem,
    'Conjured Mana Cake' => ConjuredItem
  }

  def initialize(items)
    @items = items
  end

  def update_quality
    sort_items
    @items.each do |item| 
      item.update_quality
      update_sell_in(item)
    end
  end

  def sort_items
    @items.map! do |item|
      item = SPECIAL_ITEMS[item.name].new(name = item.name, sell_in = item.sell_in, quality = item.quality)
    end
  end

  def update_sell_in(item)
    return if item.name == 'Sulfuras, Hand of Ragnaros'

    item.sell_in -= 1
  end

end
