# frozen_string_literal: true
require_relative 'normal_item'

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
  end

  class NormalItem < Item

    def update_quality
      @quality -= 1 if !min_quality?
      @quality -= 1 if !min_quality? && out_of_date?
    end

    def min_quality?
      @quality == 0
    end

    def out_of_date?
      @sell_in <= 0
    end

  end


  class LegendaryItem < Item

    def update_quality
      return
    end

  end