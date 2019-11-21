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
    @items.each { |item| item.update_quality }
  end

  def sort_items
    @items.map! do |item|
      item = SPECIAL_ITEMS[item.name].new(name = item.name, sell_in = item.sell_in, quality = item.quality)
    end
  end

end
