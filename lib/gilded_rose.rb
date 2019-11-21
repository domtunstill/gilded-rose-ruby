# frozen_string_literal: true

require_relative 'item'

# GildedRose class is the default class and handles the list of items
class GildedRose
  SPECIAL_ITEMS = {
    'Sulfuras, Hand of Ragnaros' => LegendaryItem,
    'Aged Brie' => CheeseItem,
    'Backstage passes to a TAFKAL80ETC concert' => BackstagePassItem,
    'Conjured Mana Cake' => ConjuredItem
  }.freeze

  def initialize(items)
    @items = items
    sort_items
  end

  def update_quality
    @items.each(&:update_quality)
  end

  def sort_items
    @items.map! do |item|
      if SPECIAL_ITEMS.include?(item.name)
        SPECIAL_ITEMS[item.name].new(item.name, item.sell_in, item.quality)
      else
        NormalItem.new(item.name, item.sell_in, item.quality)
      end
    end
  end
end
