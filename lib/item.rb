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

class MainItem < Item

  def max_quality?
    @quality == 50
  end

  def min_quality?
      @quality == 0
  end

  def out_of_date?
  @sell_in <= 0
  end

end

class NormalItem < MainItem

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


class LegendaryItem < MainItem

  def update_quality
    return
  end

end


class CheeseItem < MainItem

  def update_quality
    @quality += 1 if !max_quality?
    @quality += 1 if !max_quality? && out_of_date?
  end

  def max_quality?
    @quality == 50
  end

  def out_of_date?
    @sell_in <= 0
  end

end

  class BackstagePassItem < MainItem

    def update_quality
      return @quality = 0 if out_of_date?
  
      @quality += 1 if !max_quality? && @sell_in < 6
      @quality += 1 if !max_quality? && @sell_in < 11
      @quality += 1 if !max_quality?
    end

    def max_quality?
      @quality == 50
    end
  
    def out_of_date?
      @sell_in <= 0
    end

  end

  class ConjuredItem < MainItem

    def update_quality
      @quality -= 2 if !min_quality?
      @quality -= 2 if !min_quality? && out_of_date? 
    end

    def min_quality?
      @quality == 0
    end
  
    def out_of_date?
      @sell_in <= 0
    end
    
  end
