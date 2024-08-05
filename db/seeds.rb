
# Seed data
products = [
  {
    name: "Product 1",
    description: "Description for product 1",
    price: 10.99,
    cost: 5.00,
    stock_level: 100,
    category: "Category A",
    created_at: Time.now,
    updated_at: Time.now
  },
  {
    name: "Product 2",
    description: "Description for product 2",
    price: 15.99,
    cost: 7.50,
    stock_level: 200,
    category: "Category B",
    created_at: Time.now,
    updated_at: Time.now
  },
  {
    name: "Product 3",
    description: "Description for product 3",
    price: 20.99,
    cost: 10.00,
    stock_level: 150,
    category: "Category C",
    created_at: Time.now,
    updated_at: Time.now
  }
]

# Create products
products.each do |product|
  Product.create!(product)
end

puts "Seed data created successfully."
