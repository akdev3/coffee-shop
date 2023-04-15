items = [
  {
    name: 'Coffee',
    price: 10
  },
  {
    name: 'Espresso',
    price: 15
  },
  {
    name: 'Americano',
    price: 20
  },
  {
    name: 'Latte',
    price: 25
  },
  {
    name: 'Mocha',
    price: 30
  },
  {
    name: 'Macchiato',
    price: 35
  },
  {
    name: 'Drip Coffee',
    price: 40
  },
  {
    name: 'Free Coffee',
    price: 0
  },
  {
    name: 'Beverages',
    price: 10
  },
  {
    name: 'Sandwich',
    price: 20
  }
]
items.each do |item|
  Item.find_or_create_by(item)
end

customers = [
  {
    name: 'Customer 1',
    email: 'customer1@gmail.com'
  },
  {
    name: 'Customer 2',
    email: 'customer2@gmail.com'
  },
  {
    name: 'Customer 3',
    email: 'customer3@gmail.com'
  },
  {
    name: 'Customer 4',
    email: 'customer4@gmail.com'
  },
  {
    name: 'Customer 5',
    email: 'customer5@gmail.com'
  }
]
customers.each do |customer|
  Customer.find_or_create_by(customer)
end

group_item_1 = GroupItem.create(name: "Deal 1", disc_amount: 10)
group_item_2 = GroupItem.create(name: "Deal 2", disc_amount: 20)

first_three_items = Item.first(3)
last_three_items = Item.last(3)

first_three_items.each do |item|
  group_item_1.items << item
end

last_three_items.each do |item|
  group_item_2.items << item
end

free_item = Item.find_by(price: 0)
valued_items = Item.where.not(price: 0)

PromotionLineItem.create(source_item: valued_items.first, dest_item: free_item)
PromotionLineItem.create(source_item: valued_items.second, dest_item: free_item)

puts 'Records added successfully!'
