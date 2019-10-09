categories = ["Adventure", "Sport", "Visits", "Workshops", "Cultural", "Food"
]

# TODO: your code goes here
puts "What extra category would you like to add?"
extra_category = gets.chomp.capitalize
categories = categories << extra_category
categories = categories.sort
puts"Thank you, so currently, the categories of activities are:"
categories.each do |category|
  puts "- #{category}"
end

size_categories = categories.size
puts "Total number of categories: #{size_categories}"
