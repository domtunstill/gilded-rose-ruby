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
        if item.quality < 50
          item.quality += 1 if item.name == 'Aged Brie'
          backstage_pass_quality(item) if item.name == 'Backstage passes to a TAFKAL80ETC concert'
        end
      end

      update_sell_in(item)

      # takes away another 1 from normal item qualities if above 0 and less than 0 for sell_in
      if item.sell_in < 0
        if item.name != 'Aged Brie'
          if item.name != 'Backstage passes to a TAFKAL80ETC concert'
            if item.quality > 0
              item.quality -= 1 if item.name != 'Sulfuras, Hand of Ragnaros'
            end
          else
            # sets quality to 0 for backstage pass if sell_in date is less than 0
            item.quality = 0
          end
        else
          # otherwise adds another 1 to the quality of the bree
          item.quality += 1 if item.quality < 50
        end
      end
    end
  end

  def update_sell_in(item)
    return if item.name == 'Sulfuras, Hand of Ragnaros'

    item.sell_in -= 1
  end

  def backstage_pass_quality(item)
    item.quality += 1 if item.sell_in < 6
    item.quality += 1 if item.sell_in < 11
    item.quality += 1
  end
  
end
