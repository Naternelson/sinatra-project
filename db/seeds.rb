user = User.create(email: "email@email.com", password: "password", first_name: "John", last_name: "Smith")
puts "New User Created"
puts
i = 1
while i < 11 do
    user.products << Product.create(name: "Product##{i}", sku: "#{999+i}", description: "This is Product #{i}", color:"white", company:"CORP Progress")
    puts "##{i} Product Created"
    i += 1
end
puts
puts "Seed Products Created"
puts
user.products.each do |p| 
    p.item_requirements << ItemRequirement.create(name: "Device", length: 6, description: "DUMMY", length_required: true, unique: true)
    puts "Adding item Requirements to products"
end
puts
puts "Seed Requirements Added"
puts
i = 0

while i < 5 do
    user.products[i].orders << Order.create(order_num: 100+i, amount: 1000, status: 0)
    puts "#{i} Order Created"
    i += 1
end
puts
puts "Seed Orders Created"
puts
puts "==>Seed DB Complete<=="