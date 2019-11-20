# frozen_string_literal: true

require 'item'

describe Item do
    let(:item) {Item.new(name = 'Elixir of the Mongoose', sell_in = 5, quality = 10)}
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