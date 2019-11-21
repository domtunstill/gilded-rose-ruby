# frozen_string_literal: true

require_relative 'item'

# GildedRose class is the default class and handles the list of items
class GildedRose
  def initialize(items, **item_classes)
    @items = items
    @normal_item = item_classes[:normal_item] || NormalItem
    @special_items = {
      'Sulfuras, Hand of Ragnaros' => item_classes[:legendary_item] || LegendaryItem,
      'Aged Brie' => item_classes[:cheese_item] || CheeseItem,
      'Backstage passes to a TAFKAL80ETC concert' => item_classes[:backstage_pass_item] || BackstagePassItem,
      'Conjured Mana Cake' => item_classes[:conjured_item] || ConjuredItem
    }

    sort_items
  end

  def sort_items
    @items.map! do |item|
      if @special_items.include?(item.name)
        @special_items[item.name].new(item.name, item.sell_in, item.quality)
      else
        @normal_item.new(item.name, item.sell_in, item.quality)
      end
    end
  end

  def update_quality
    @items.each(&:update_quality)
  end
end
