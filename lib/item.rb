# frozen_string_literal: true

# Item class is the default item class which hasn't been changed and has info about each item sell_in, quality and name
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

# MainItem class inherits from the Item class and has methods shared amongst it's children
class MainItem < Item
  def update_sell_in
    @sell_in -= 1
  end

  def max_quality?
    @quality == 50
  end

  def min_quality?
    @quality.zero?
  end

  def out_of_date?
    @sell_in <= 0
  end
end

# LegendaryItem class inherits from the Item class not the MainItem class and updates quality values for normal items
class LegendaryItem < Item
  def update_quality
    nil
  end
end

# NormalItem class inherits from the MainItem class and updates quality values for normal items
class NormalItem < MainItem
  def update_quality
    @quality -= 1 unless min_quality?
    @quality -= 1 if !min_quality? && out_of_date?
    update_sell_in
  end
end

# CheeseItem class inherits from the MainItem class and updates quality values for cheesy items
class CheeseItem < MainItem
  def update_quality
    @quality += 1 unless max_quality?
    @quality += 1 if !max_quality? && out_of_date?
    update_sell_in
  end
end

# BackstagePassItem class inherits from the MainItem class and updates quality values for backstage pass items
class BackstagePassItem < MainItem
  def update_quality
    return @quality = 0 if out_of_date?

    @quality += 1 if !max_quality? && @sell_in < 6
    @quality += 1 if !max_quality? && @sell_in < 11
    @quality += 1 unless max_quality?
    update_sell_in
  end
end

# ConjuredItem class inherits from the MainItem class and updates quality values for conjured items
class ConjuredItem < MainItem
  def update_quality
    @quality -= 2 unless min_quality?
    @quality -= 2 if !min_quality? && out_of_date?
    update_sell_in
  end
end
