# frozen_string_literal: true

require 'gilded_rose'

describe GildedRose do

  describe 'hash of SPECIAL_ITEMS in GildedRose class' do
    it 'has Sulfuras, Hand of Ragnaros stored' do
      expect(GildedRose::SPECIAL_ITEMS).to include('Sulfuras, Hand of Ragnaros')
    end
    it 'has Backstage passes to a TAFKAL80ETC concert stored' do
      expect(GildedRose::SPECIAL_ITEMS).to include('Backstage passes to a TAFKAL80ETC concert')
    end
    it 'has Aged Brie stored' do
      expect(GildedRose::SPECIAL_ITEMS).to include('Aged Brie')
    end
    it 'has Conjured Mana Cake has stored' do
      expect(GildedRose::SPECIAL_ITEMS).to include('Conjured Mana Cake')
    end
  end

  describe '#sort_items' do

    it 'returns an array of sorted normal item objects' do
      items = [Item.new(name = 'Elixir of the Mongoose', sell_in = 0, quality = 0)]
      list = GildedRose.new(items)
      list.sort_items
      expect(items[0].class).to eq NormalItem
    end

    it 'returns an array of sorted normal item objects' do
      items = [Item.new(name = '+5 Dexterity Vest', sell_in = 0, quality = 0)]
      list = GildedRose.new(items)
      list.sort_items
      expect(items[0].class).to eq NormalItem
    end

    it 'returns an array of sorted legendary item objects' do
      items = [Item.new(name = 'Sulfuras, Hand of Ragnaros', sell_in = 0, quality = 80)]
      list = GildedRose.new(items)
      list.sort_items
      expect(items[0].class).to eq LegendaryItem
    end

    it 'returns an array of sorted cheese item objects' do
      items = [Item.new(name = 'Aged Brie', sell_in = 0, quality = 12)]
      list = GildedRose.new(items)
      list.sort_items
      expect(items[0].class).to eq CheeseItem
    end

    it 'returns an array of sorted backstage pass item objects' do
      items = [Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 10, quality = 12)]
      list = GildedRose.new(items)
      list.sort_items
      expect(items[0].class).to eq BackstagePassItem
    end

    it 'returns an array of sorted conjured item objects' do
      items = [Item.new(name = 'Conjured Mana Cake', sell_in = 10, quality = 12)]
      list = GildedRose.new(items)
      list.sort_items
      expect(items[0].class).to eq ConjuredItem
    end

  end

  describe '#update_quality' do
    it 'does not change the name' do
      items = [Item.new(name = 'Elixir of the Mongoose', sell_in = 0, quality = 0)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'Elixir of the Mongoose'
    end

    it 'All items: quality of item cannot go negative' do
      items = [Item.new(name = 'Elixir of the Mongoose', sell_in = 0, quality = 0)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 0
    end

    it 'Sulfuras: never decrease/increase in quality' do
      items = [Item.new(name = 'Sulfuras, Hand of Ragnaros', sell_in = 0, quality = 80)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 80
    end

    it 'Sulfuras: never decrease/increase sellIn date' do
      items = [Item.new(name = 'Sulfuras, Hand of Ragnaros', sell_in = 0, quality = 80)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq 0
    end

    it 'Brie: items quality never more than 50' do
      items = [Item.new(name = 'Aged Brie', sell_in = 20, quality = 50)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 50
    end

    it 'Backstage: items quality never more than 50' do
      items = [Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 20, quality = 50)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 50
    end

    it 'Normal: item decreases quality each day' do
      items = [Item.new(name = 'Elixir of the Mongoose', sell_in = 10, quality = 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 9
    end

    it 'Normal: item decreases sell_in each day' do
      items = [Item.new(name = 'Elixir of the Mongoose', sell_in = 10, quality = 10)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq 9
    end

    it 'Normal: quality twice decreases as fast after sell_in' do
      items = [Item.new(name = 'Elixir of the Mongoose', sell_in = 0, quality = 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 8
    end

    it 'Brie: items quality increases in value as it gets older' do
      items = [Item.new(name = 'Aged Brie', sell_in = 5, quality = 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 11
    end

    it 'Brie: quality increases twice as fast after sellin date' do
      items = [Item.new(name = 'Aged Brie', sell_in = 0, quality = 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 12
    end

    it 'Brie: sell_in value descreases by 1 each day' do
      items = [Item.new(name = 'Aged Brie', sell_in = 10, quality = 10)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq 9
    end

    it 'Backstage: quality increases as approach concert date' do
      items = [Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 20, quality = 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 11
    end

    it 'Backstage: quality increases twice as fast once less than 10 days until concert date' do
      items = [Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 9, quality = 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 12
    end

    it 'Backstage: quality increases three times as fast once less than 5 days until concert date' do
      items = [Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 4, quality = 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 13
    end

    it 'Backstage: Quality drops to 0 after the concert' do
      items = [Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 0, quality = 50)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 0
    end

    it 'Backstage: sell_in value descreases by 1 each day' do
      items = [Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 10, quality = 10)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq 9
    end

    it 'Conjured: quality of item cannot go negative' do
      items = [Item.new(name = 'Conjured Mana Cake', sell_in = 0, quality = 0)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 0
    end
    it 'Conjured: item decreases quality by 2 each day' do
      items = [Item.new(name = 'Conjured Mana Cake', sell_in = 10, quality = 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 8
    end

    it 'Conjured: quality twice decreases as fast after sell_in' do
      items = [Item.new(name = 'Conjured Mana Cake', sell_in = 0, quality = 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 6
    end
  end

end
