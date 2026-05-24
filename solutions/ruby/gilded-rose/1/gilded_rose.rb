class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name:, sell_in:, quality:)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end
end

class GildedRose
  def initialize(items)
    @items = items
  end

  def update!
    @items.each do |item|
      conjured = item.name.start_with?('Conjured ')
      base_name = conjured ? item.name.sub('Conjured ', '') : item.name

      item.sell_in -= 1 unless base_name.downcase == 'sulfuras, hand of ragnaros' && !conjured

      if conjured && item.sell_in < 0
        item.quality = 0
        next
      end

      case base_name.downcase
      when 'aged brie'
        item.quality += 1 if item.quality < 50
        item.quality += 1 if item.sell_in < 0 && item.quality < 50
      when 'backstage passes to a tafkal80etc concert'
        update_backstage(item, conjured)
      when 'sulfuras, hand of ragnaros'
      else
        rate = conjured ? 2 : 1
        item.quality -= rate
        item.quality -= rate if item.sell_in < 0
      end

      item.quality = 50 if item.quality > 50 && base_name.downcase != 'sulfuras, hand of ragnaros'
      item.quality = 0 if item.quality < 0
    end
  end

  private

  def update_backstage(item, conjured)
    if item.sell_in < 0
      item.quality = 0
    else
      increase = if item.sell_in < 5
                   3
                 elsif item.sell_in < 10
                   2
                 else
                   1
                 end
      increase -= 1 if conjured && increase > 0
      item.quality += increase
    end
  end
end
