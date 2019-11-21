# frozen_string_literal: true

require 'gilded_rose'

describe GildedRose do
  let(:normal_item) do
    double :normal_item,
           name: 'Elixir of the Mongoose',
           sell_in: 0,
           quality: 0
  end
  let(:conjured_item) do
    double :conjured_item,
           name: 'Conjured Mana Cake',
           sell_in: 0,
           quality: 0
  end
  let(:cheese_item) do
    double :cheese_item,
           name: 'Aged Brie',
           sell_in: 0,
           quality: 0
  end
  let(:legendary_item) do
    double :legendary_item,
           name: 'Sulfuras, Hand of Ragnaros',
           sell_in: 0,
           quality: 0
  end
  let(:backstage_pass_item) do
    double :backstage_pass_item,
           name: 'Backstage passes to a TAFKAL80ETC concert',
           sell_in: 0,
           quality: 0
  end

  let(:normal_item_class) { double :normal_item_class, new: normal_item }
  let(:conjured_item_class) { double :conjured_class, new: conjured_item }
  let(:cheese_item_class) { double :cheese_class, new: cheese_item }
  let(:legendary_item_class) { double :legendary_class, new: legendary_item }
  let(:backstage_pass_item_class) { double :backstage_pass_class, new: backstage_pass_item }

  let(:items) do
    [
      normal_item,
      conjured_item,
      cheese_item,
      legendary_item,
      backstage_pass_item
    ]
  end

  let(:item_classes) do
    {
      normal_item: normal_item_class,
      conjured_item: conjured_item_class,
      cheese_item: cheese_item_class,
      legendary_item: legendary_item_class,
      backstage_pass_item: backstage_pass_item_class
    }
  end

  let(:gilded_rose) do
    described_class.new(
      items,
      item_classes
    )
  end

  describe '#sort_items' do
    it 'creates a new normal item if normal item is in the array' do
      expect(normal_item_class).to receive(:new)
      gilded_rose.sort_items
    end

    it 'creates a new legendary item if special item is in the array' do
      expect(legendary_item_class).to receive(:new)
      gilded_rose.sort_items
    end

    it 'creates a new cheese item if special item is in the array' do
      expect(cheese_item_class).to receive(:new)
      gilded_rose.sort_items
    end

    it 'creates a new backstage item if special item is in the array' do
      expect(backstage_pass_item_class).to receive(:new)
      gilded_rose.sort_items
    end

    it 'creates a new conjured stage item if special item is in the array' do
      expect(conjured_item_class).to receive(:new)
      gilded_rose.sort_items
    end
  end

  describe '#update_quality' do
    before :each do
      allow(normal_item).to receive(:update_quality)
      allow(cheese_item).to receive(:update_quality)
      allow(backstage_pass_item).to receive(:update_quality)
      allow(legendary_item).to receive(:update_quality)
      allow(conjured_item).to receive(:update_quality)
    end

    it 'does not change the name' do
      allow(gilded_rose).to receive(:update_quality)
      gilded_rose.update_quality
      expect(items[0].name).to eq 'Elixir of the Mongoose'
    end

    it 'calls updated_quality method on a normal item' do
      expect(normal_item).to receive(:update_quality)
      gilded_rose.update_quality
    end

    it 'calls updated_quality method on a legendary item' do
      expect(legendary_item).to receive(:update_quality)
      gilded_rose.update_quality
    end

    it 'calls updated_quality method on a cheese item' do
      expect(cheese_item).to receive(:update_quality)
      gilded_rose.update_quality
    end

    it 'calls updated_quality method on a backstage pass item' do
      expect(backstage_pass_item).to receive(:update_quality)
      gilded_rose.update_quality
    end

    it 'calls updated_quality method on a conjured item' do
      expect(conjured_item).to receive(:update_quality)
      gilded_rose.update_quality
    end
  end
end
