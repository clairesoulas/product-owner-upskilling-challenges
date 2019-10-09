activity = {
  "name" => "Atelier theatre", #String
  "category" => "Cultural", #String
  "city" => "Nantes", #String
  "duration" => 120, #Integer
  "participants" => 12, #Integer
  "price" => 20 #Integer
}

# TODO: your code goes here
puts "#{activity["name"]} [#{activity["category"].upcase}]"
puts "Located in #{activity["city"]}"
puts "Duration of #{activity["duration"]} minutes"
puts "For #{activity["participants"]} participants"
puts "Charged #{activity["price"]}€ per participant"
