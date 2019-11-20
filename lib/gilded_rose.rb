# frozen_string_literal: true

require 'item'

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      # takes away 1 from normal item qualities if above 0
      if (item.name != 'Aged Brie') && (item.name != 'Backstage passes to a TAFKAL80ETC concert')
        if item.quality > 0
          item.quality -= 1 if item.name != 'Sulfuras, Hand of Ragnaros'
        end
      else
        # adds 1 to special items if quality is less than 50
        brie_quality(item) if item.name == 'Aged Brie'
        backstage_pass_quality(item) if item.name == 'Backstage passes to a TAFKAL80ETC concert'
      end

      update_sell_in(item)

      # takes away another 1 from normal item qualities if above 0 and less than 0 for sell_in
      if item.sell_in < 0
        if item.name != 'Aged Brie'
          if item.name != 'Backstage passes to a TAFKAL80ETC concert'
            if item.quality > 0
              item.quality -= 1 if item.name != 'Sulfuras, Hand of Ragnaros'
            end
          end
        end
      end
    end
  end

  def update_sell_in(item)
    return if item.name == 'Sulfuras, Hand of Ragnaros'

    item.sell_in -= 1
  end

  def backstage_pass_quality(item)
    return item.quality = 0 if item.sell_in <= 0
    item.quality += 1 if item.sell_in < 6 && item.quality < 50
    item.quality += 1 if item.sell_in < 11 && item.quality < 50
    item.quality += 1 if item.quality < 50
  end

  def brie_quality(item)
    item.quality += 1 if item.quality < 50
    item.quality += 1 if item.sell_in <= 0 && item.quality < 50
  end
  
end
