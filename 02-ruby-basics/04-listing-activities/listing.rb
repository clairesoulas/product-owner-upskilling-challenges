activities = [
  # TODO: gather at least 3 activities
  {
  "name" => "Atelier theatre", #String
  "category" => "Cultural", #String
  "city" => "Nantes", #String
  "duration" => 120, #Integer
  "participants" => 12, #Integer
  "price" => 20 #Integer
},
{
  "name" => "Escape game", #String
  "category" => "Adventure", #String
  "city" => "Nantes", #String
  "duration" => 75, #Integer
  "participants" => 6, #Integer
  "price" => 20 #Integer
},
{
  "name" => "Stage de survie", #String
  "category" => "Adventure", #String
  "city" => "La forêt", #String
  "duration" => 180, #Integer
  "participants" => 6, #Integer
  "price" => 150 #Integer
}

]

# TODO: your code goes here
activities.each do |activity|
puts "#{activity["name"]} [#{activity["category"].upcase}]"
puts "Located in #{activity["city"]}"
puts "Duration of #{activity["duration"]} minutes"
puts "For #{activity["participants"]} participants"
puts "Charged #{activity["price"]}€ per participant"
puts "---"
end
