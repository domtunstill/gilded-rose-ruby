# frozen_string_literal: true

require 'gilded_rose'

describe GildedRose do
  let(:subject) { described_class.new([]) }

  describe 'array of SPECIAL_ITEMS in GildedRose class' do
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
  end

  describe '#update_sell_in' do
    it 'Sulfuras: never decrease/increase sellIn date' do
      item = Item.new(name = 'Sulfuras, Hand of Ragnaros', sell_in = 0, quality = 80)
      subject.update_sell_in(item)
      expect(item.sell_in).to eq 0
    end

    it 'Normal: item decreases sell_in each day' do
      item = Item.new(name = 'Elixir of the Mongoose', sell_in = 10, quality = 10)
      subject.update_sell_in(item)
      expect(item.sell_in).to eq 9
    end

    it 'Brie: sell_in value descreases by 1 each day' do
      item = Item.new(name = 'Aged Brie', sell_in = 10, quality = 10)
      subject.update_sell_in(item)
      expect(item.sell_in).to eq 9
    end

    it 'Backstage: sell_in value descreases by 1 each day' do
      item = Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 10, quality = 10)
      subject.update_sell_in(item)
      expect(item.sell_in).to eq 9
    end
  end

  describe '#backstage_pass_quality' do
    it 'Backstage: quality increases as approach concert date' do
      item = Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 20, quality = 10)
      subject.backstage_pass_quality(item)
      expect(item.quality).to eq 11
    end

    it 'Backstage: quality increases as approach concert date' do
      item = Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 20, quality = 15)
      subject.backstage_pass_quality(item)
      expect(item.quality).to eq 16
    end

    it 'Backstage: quality increases twice as fast once less than 10 days until concert date' do
      item = Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 9, quality = 10)
      subject.backstage_pass_quality(item)
      expect(item.quality).to eq 12
    end

    it 'Backstage: quality increases three times as fast once less than 5 days until concert date' do
      item = Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 4, quality = 10)
      subject.backstage_pass_quality(item)
      expect(item.quality).to eq 13
    end

    it 'Backstage: items quality never more than 50' do
      item = Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 4, quality = 48)
      subject.backstage_pass_quality(item)
      expect(item.quality).to eq 50
    end

    it 'Backstage: items quality never more than 50' do
      item = Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 20, quality = 50)
      subject.backstage_pass_quality(item)
      expect(item.quality).to eq 50
    end

    it 'Backstage: items quality never more than 50' do
      item = Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 8, quality = 49)
      subject.backstage_pass_quality(item)
      expect(item.quality).to eq 50
    end

    it 'Backstage: Quality drops to 0 after the concert' do
      item = Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 0, quality = 50)
      subject.backstage_pass_quality(item)
      expect(item.quality).to eq 0
    end
  end

  describe '#brie_quality' do
    it 'Brie: items quality never more than 50' do
      item = Item.new(name = 'Aged Brie', sell_in = 20, quality = 50)
      subject.brie_quality(item)
      expect(item.quality).to eq 50
    end
    it 'Brie: items quality increases in value as it gets older' do
      item = Item.new(name = 'Aged Brie', sell_in = 5, quality = 10)
      subject.brie_quality(item)
      expect(item.quality).to eq 11
    end
    it 'Brie: quality increases twice as fast after sellin date' do
      item = Item.new(name = 'Aged Brie', sell_in = 0, quality = 10)
      subject.brie_quality(item)
      expect(item.quality).to eq 12
    end
  end

  describe '#normal_item_quality' do
    it 'All items: quality of item cannot go negative' do
      item = Item.new(name = 'Elixir of the Mongoose', sell_in = 0, quality = 0)
      subject.normal_item_quality(item)
      expect(item.quality).to eq 0
    end
    it 'Normal: item decreases quality each day' do
      item = Item.new(name = 'Elixir of the Mongoose', sell_in = 10, quality = 10)
      subject.normal_item_quality(item)
      expect(item.quality).to eq 9
    end

    it 'Normal: quality twice decreases as fast after sell_in' do
      item = Item.new(name = 'Elixir of the Mongoose', sell_in = 0, quality = 10)
      subject.normal_item_quality(item)
      expect(item.quality).to eq 8
    end
  end

  describe '#conjured_item_quality' do
    it 'Conjured: quality of item cannot go negative' do
      item = Item.new(name = 'Conjured Mana Cake', sell_in = 0, quality = 0)
      subject.conjured_item_quality(item)
      expect(item.quality).to eq 0
    end
    it 'Conjured: item decreases quality by 2 each day' do
      item = Item.new(name = 'Conjured Mana Cake', sell_in = 10, quality = 10)
      subject.conjured_item_quality(item)
      expect(item.quality).to eq 8
    end

    it 'Conjured: quality twice decreases as fast after sell_in' do
      item = Item.new(name = 'Conjured Mana Cake', sell_in = 0, quality = 10)
      subject.conjured_item_quality(item)
      expect(item.quality).to eq 6
    end
  end
end
