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

  let(:subject) { described_class.new(name = 'Elixir of the Mongoose', sell_in = 5, quality = 10) }

  it 'Normal: item decreases quality each day' do
    subject.update_quality
    expect(subject.quality).to eq 9
  end

  # it 'Normal: item decreases sell_in each day' do
  #   items = [Item.new(name = 'Elixir of the Mongoose', sell_in = 10, quality = 10)]
  #   GildedRose.new(items).update_quality
  #   expect(items[0].sell_in).to eq 9
  # end

  # it 'Normal: quality twice decreases as fast after sell_in' do
  #   items = [Item.new(name = 'Elixir of the Mongoose', sell_in = 0, quality = 10)]
  #   GildedRose.new(items).update_quality
  #   expect(items[0].quality).to eq 8
  # end
end