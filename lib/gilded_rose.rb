# frozen_string_literal: true

require_relative 'item'

class GildedRose

  SPECIAL_ITEMS = { 
    'Sulfuras, Hand of Ragnaros' => LegendaryItem,
    'Aged Brie' => CheeseItem,
    'Backstage passes to a TAFKAL80ETC concert' => BackstagePassItem,
    'Conjured Mana Cake' => ConjuredItem
  }

  def initialize(items)
    @items = items
    sort_items
  end

  def update_quality
    @items.each { |item| item.update_quality }
  end

  def sort_items
    @items.map! do |item|
      if SPECIAL_ITEMS.include?(item.name)
        item = SPECIAL_ITEMS[item.name].new(name = item.name, sell_in = item.sell_in, quality = item.quality)
      else
        item = NormalItem.new(name = item.name, sell_in = item.sell_in, quality = item.quality)
      end
    end
  end

end
