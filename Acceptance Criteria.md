## Acceptance Criteria

- All items have a SellIn value which denotes the number of days we have to sell the item /
- All items have a Quality value which denotes how valuable the item is /
- At the end of each day our system lowers both values for every item /

- Once SellIn date is passed quality degrades twice as fast /
- The Quality of an item is never negative /
- "Aged Brie" actually increases in Quality the older it gets /
- The Quality of an item is never more than 50 /
- "Sulfuras", being a legendary item, never has to be sold or decreases in Quality /
- "Sulfuras" is a legendary item and as such its Quality is 80 and it never alters.
- "Backstage passes", like aged brie, increases in Quality as its SellIn value approaches; /
    Quality increases by 2 when there are 10 days or less and /
    by 3 when there are 5 days or less /
    but Quality drops to 0 after the concert /

New feature. We have recently signed a supplier of conjured items. This requires an update to our system:
- "Conjured" items degrade in Quality twice as fast as normal items

- No changes to item class

- Any changes to be update Quaility and guild rose

## Testing Criteria

| Criteria      | Input         | Output|
| ------------- |:-------------:| -----:|
| All: quality of item is never negative  | Item.new(name = 'Elixir of the Mongoose', sell_in = 0, quality = 0) Days 1 | quality = 0 |
| Sulfuras: never decrease/increase in quality  |  Item.new(name = 'Sulfuras, Hand of Ragnaros', sell_in = 0, quality = 80) Days 1 | quality = 80 |
| Sulfuras: never decrease/increase sellIn date |  Item.new(name = 'Sulfuras, Hand of Ragnaros', sell_in = 0, quality = 80) Days 1 | sell_in = 0 |
| Normal: item decreases quality each day | Item.new(name = 'Elixir of the Mongoose', sell_in = 10, quality = 10) Days 1 | quality = 9 |
| Normal: item decreases sell_in each day | Item.new(name = 'Elixir of the Mongoose', sell_in = 10, quality = 10) Days 1 | sell_in = 9 |
| Normal: quality twice decreases as fast after sell_in | Item.new(name = 'Elixir of the Mongoose', sell_in = 0, quality = 10) Days 1 | quality = 8 |
| Brie: items quality never more than 50 |  Item.new(name = 'Aged Brie', sell_in = 20, quality = 50) Days 1 | quality = 50 |
| Brie: items quality increases in value as it gets older |  Item.new(name = 'Aged Brie', sell_in = 5, quality = 10) Days 1 | quality = 11 |
| Brie: quality increases twice as fast after sellin date |  Item.new(name = 'Aged Brie', sell_in = 0, quality = 10) Days 1 | quality = 12
| Brie: sell_in value descreases by 1 each day | Item.new(name = 'Aged Brie', sell_in = 10, quality = 10) Days 1 | sell_in = 9 |
| Backstage: items quality never more than 50 |  Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 20, quality = 50) Days 1 | quality = 50 |
| Backstage: quality increases as approach concert date |  Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 20, quality = 10) Days 1 | quality = 11 |
| Backstage: quality increases twice as fast once less than 10 days until concert date |  Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 9, quality = 20) Days 1 | quality = 22 |
| Backstage: quality increases three times as fast once less than 5 days until concert date |  Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 4, quality = 30) Days 1 | quality = 33 |
| Backstage: Quality drops to 0 after the concert |  Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 0, quality = 50) Days 1 | quality = 0 |
| Backstage: sell_in value descreases by 1 each day | Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 10, quality = 10) Days 1 | sell_in = 9 |
| Conjured: decrease in quality twice as fast as normal items | Item.new(name = 'Conjured Mana Cake', sell_in = 10, quality = 10) Days 1 | sell_in = 9 |
| Conjured: decrease in quality twice as fast as normal items | Item.new(name = 'Conjured Mana Cake', sell_in = 10, quality = 10) Days 1 | quality = 8 |
| Conjured: decrease in quality twice as fast as normal items, passed sell_in date | Item.new(name = 'Conjured Mana Cake', sell_in = 0, quality = 10) Days 1 | quality = 6 |

### Edge cases

- User adds items with quality more than 50
- User adds items with quality less than 0