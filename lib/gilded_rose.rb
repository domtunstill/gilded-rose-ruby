# frozen_string_literal: true

require 'item'

class GildedRose

  SPECIAL_ITEMS = ['Aged Brie', 'Backstage passes to a TAFKAL80ETC concert', 'Sulfuras, Hand of Ragnaros']

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      normal_item_quality(item) unless SPECIAL_ITEMS.include?(item.name)
      brie_quality(item) if item.name == SPECIAL_ITEMS[0]
      backstage_pass_quality(item) if item.name == SPECIAL_ITEMS[1]
      update_sell_in(item)
    end
  end

  def update_sell_in(item)
    return if item.name == 'Sulfuras, Hand of Ragnaros'

    item.sell_in -= 1
  end

  def backstage_pass_quality(item)
    return item.quality = 0 if item.sell_in <= 0
    item.quality += 1 if item.sell_in < 6 && !max_quality?(item)
    item.quality += 1 if item.sell_in < 11 && !max_quality?(item)
    item.quality += 1 if !max_quality?(item)
  end

  def brie_quality(item)
    item.quality += 1 if !max_quality?(item)
    item.quality += 1 if item.sell_in <= 0 && !max_quality?(item)
  end

  def normal_item_quality(item)
    item.quality -= 1 if item.quality > 0
    item.quality -= 1 if item.quality > 0 && item.sell_in <= 0
  end

  private

  def max_quality?(item)
    item.quality >= 50
  end
  
end
