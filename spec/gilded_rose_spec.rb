# frozen_string_literal: true

require 'gilded_rose'

describe GildedRose do
  describe '#update_quality' do
    it 'does not change the name' do
      items = [Item.new(name = 'Elixir of the Mongoose', sell_in = 0, quality = 0)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'Elixir of the Mongoose'
    end

    it 'All items: quality of item is never negative' do
      items = [Item.new(name = 'Elixir of the Mongoose', sell_in = 0, quality = 0)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 0
    end

    it 'Sulfuras: never decrease/increase in quality' do
      items = [Item.new(name = 'Sulfuras, Hand of Ragnaros', sell_in = 0, quality = 80)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 80
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
  end

  describe '#update_sell_in' do
    let(:subject) { described_class.new([]) }

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
    let(:subject) { described_class.new([]) }

    it 'Backstage: quality increases as approach concert date' do
      item = Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 20, quality = 10)
      subject.backstage_pass_quality(item)
      expect(item.quality).to eq 11
    end


    it 'Backstage: quality increases twice as fast once less than 10 days until concert date' do
      item = Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 9, quality = 10)
      subject.backstage_pass_quality(item)
      expect(item.quality).to eq 12
    end

    # it 'Backstage: quality increases three times as fast once less than 5 days until concert date' do
    #   items = [Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 4, quality = 10)]
    #   GildedRose.new(items).update_quality
    #   expect(items[0].quality).to eq 13
    # end

    # it 'Backstage: Quality drops to 0 after the concert' do
    #   items = [Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 0, quality = 50)]
    #   GildedRose.new(items).update_quality
    #   expect(items[0].quality).to eq 0
    end

  end
end
