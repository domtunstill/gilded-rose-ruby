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