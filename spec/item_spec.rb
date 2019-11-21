# frozen_string_literal: true

require 'item'

describe Item do
  let(:item) { described_class.new(name = 'Elixir of the Mongoose', sell_in = 5, quality = 10) }
  describe '#initialize' do
    it 'has a name' do
      expect(item.name).to eq 'Elixir of the Mongoose'
    end
    it 'has a sell_in value' do
      expect(item.sell_in).to eq 5
    end
    it 'has a quality value' do
      expect(item.quality).to eq 10
    end
  end

  describe '#to_s' do
    it 'has a name' do
      expect(item.to_s).to eq 'Elixir of the Mongoose, 5, 10'
    end
  end
end

describe MainItem do

  describe '#max_quality?' do
    it 'returns true in max quality 50 is reached' do
      item = MainItem.new('Elixir of the Mongoose', 5, 50)
      expect(item.max_quality?).to eq true
    end

    it 'returns true in max quality 50 is not reached' do
      item = MainItem.new('Elixir of the Mongoose', 5, 45)
      expect(item.max_quality?).to eq false
    end
  end

  describe '#min_quality?' do
  it 'returns true in min quality 0 is reached' do
    item = MainItem.new('Elixir of the Mongoose', 5, 0)
    expect(item.min_quality?).to eq true
  end

  it 'returns true in min quality 0 is not reached' do
    item = MainItem.new('Elixir of the Mongoose', 5, 10)
    expect(item.min_quality?).to eq false
  end
end

end

describe NormalItem do

  it 'All items: quality of item cannot go negative' do
    normal_item = NormalItem.new(name = 'Elixir of the Mongoose', sell_in = 0, quality = 0)
    normal_item.update_quality
    expect(normal_item.quality).to eq 0
  end

  it 'Normal: item decreases quality each day' do
    normal_item = NormalItem.new(name = 'Elixir of the Mongoose', sell_in = 10, quality = 10)
    normal_item.update_quality
    expect(normal_item.quality).to eq 9
  end

  # it 'Normal: item decreases sell_in each day' do
  #   subject.update_quality
  #   expect(subject.sell_in).to eq 9
  # end

  it 'Normal: quality twice decreases as fast after sell_in' do
    normal_item = NormalItem.new(name = 'Elixir of the Mongoose', sell_in = 0, quality = 10)
    normal_item.update_quality
    expect(normal_item.quality).to eq 8
  end

end

describe LegendaryItem do

  it 'Sulfuras: never decrease/increase in quality' do
    legendary_item = LegendaryItem.new(name = 'Sulfuras, Hand of Ragnaros', sell_in = 0, quality = 80)
    legendary_item.update_quality
    expect(legendary_item.quality).to eq 80
  end

  # it 'Sulfuras: never decrease/increase sellIn date' do
  #   items = [Item.new(name = 'Sulfuras, Hand of Ragnaros', sell_in = 0, quality = 80)]
  #   GildedRose.new(items).update_quality
  #   expect(items[0].sell_in).to eq 0
  # end

end

describe CheeseItem do

  it 'Brie: items quality never more than 50' do
    cheese_item = CheeseItem.new(name = 'Aged Brie', sell_in = 20, quality = 50)
    cheese_item.update_quality
    expect(cheese_item.quality).to eq 50
  end

  it 'Brie: items quality increases in value as it gets older' do
    cheese_item = CheeseItem.new(name = 'Aged Brie', sell_in = 5, quality = 10)
    cheese_item.update_quality
    expect(cheese_item.quality).to eq 11
  end

  it 'Brie: quality increases twice as fast after sellin date' do
    cheese_item = CheeseItem.new(name = 'Aged Brie', sell_in = 0, quality = 10)
    cheese_item.update_quality
    expect(cheese_item.quality).to eq 12
  end

  # it 'Brie: sell_in value descreases by 1 each day' do
  #   cheese_item = CheeseItem.new(name = 'Aged Brie', sell_in = 10, quality = 10)
  #   cheese_item.update_quality
  #   expect(cheese_item.sell_in).to eq 9
  # end

end

describe BackstagePassItem do
  it 'Backstage: items quality never more than 50' do
    pass_item = BackstagePassItem.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 20, quality = 50)
    pass_item.update_quality
    expect(pass_item.quality).to eq 50
  end
  it 'Backstage: quality increases as approach concert date' do
    pass_item = BackstagePassItem.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 20, quality = 10)
    pass_item.update_quality
    expect(pass_item.quality).to eq 11
  end

  it 'Backstage: quality increases twice as fast once less than 10 days until concert date' do
    pass_item = BackstagePassItem.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 9, quality = 10)
    pass_item.update_quality
    expect(pass_item.quality).to eq 12
  end

  it 'Backstage: quality increases three times as fast once less than 5 days until concert date' do
    pass_item = BackstagePassItem.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 4, quality = 10)
    pass_item.update_quality
    expect(pass_item.quality).to eq 13
  end

  it 'Backstage: Quality drops to 0 after the concert' do
    pass_item = BackstagePassItem.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 0, quality = 50)
    pass_item.update_quality
    expect(pass_item.quality).to eq 0
  end

  # it 'Backstage: sell_in value descreases by 1 each day' do
  #   items = [Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 10, quality = 10)]
  #   GildedRose.new(items).update_quality
  #   expect(items[0].sell_in).to eq 9
  # end
end

describe ConjuredItem do

  it 'Conjured: quality of item cannot go negative' do
    conjured_item = ConjuredItem.new(name = 'Conjured Mana Cake', sell_in = 0, quality = 0)
    conjured_item.update_quality
    expect(conjured_item.quality).to eq 0
  end
  it 'Conjured: item decreases quality by 2 each day' do
    conjured_item = ConjuredItem.new(name = 'Conjured Mana Cake', sell_in = 10, quality = 10)
    conjured_item.update_quality
    expect(conjured_item.quality).to eq 8
  end
  it 'Conjured: quality twice decreases as fast after sell_in' do
    conjured_item = ConjuredItem.new(name = 'Conjured Mana Cake', sell_in = 0, quality = 10)
    conjured_item.update_quality
    expect(conjured_item.quality).to eq 6
  end

end
