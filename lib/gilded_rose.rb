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
      'Backstage pass' => item_classes[:backstage_pass_item] || BackstagePassItem,
      'Conjured' => item_classes[:conjured_item] || ConjuredItem
    }

    sort_items
  end

  def update_quality
    @items.each(&:update_quality)
  end

  def sort_items
    @items.map! { |item| return_class(item).new(item.name, item.sell_in, item.quality) }
  end

  private

  def return_class(item)
    @special_items.each_key { |key| return @special_items[key] if item.name.downcase.include?(key.downcase) }
    @normal_item
  end
end
