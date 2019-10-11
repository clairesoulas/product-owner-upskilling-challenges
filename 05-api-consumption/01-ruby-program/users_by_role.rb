require "json"
require "rest-client"

puts "What is the role of the users you're looking for? (e.g. Figgo - Manager)"
role_name = gets.chomp # asks user to type something in the Terminal

puts "Ok got it! Let's search for the users..."

# TODO: your code goes here

token = "18afcfb8-697b-4742-b726-418269485cee"
headers = {"Authorization" => "Lucca application=#{token}"}
url = "https://wagon.ilucca-demo.net/api/v3/roles"

response = RestClient.get(url, "params" => {"fields" => "Name,Id,UsersCount","Name" => "like,#{role_name}"}, "Authorization" => "Lucca application=#{token}")

users_of_role = JSON.parse(response.body)

count = users_of_role["data"]["items"][0]["usersCount"]
role_id = users_of_role["data"]["items"][0]["id"]

url_users = "https://wagon.ilucca-demo.net/api/v3/users"

response_users = RestClient.get(url_users, "params" => {"fields" => "firstName,lastName,department.id,jobTitle","rolePrincipal.id" => "#{role_id}"}, "Authorization" => "Lucca application=#{token}")

response_users = JSON.parse(response_users.body)

users = response_users["data"]["items"]
puts "Total: #{count} users found\n\n"
users.each do |user|
  puts "#{user["firstName"]} #{user["lastName"]}"
  puts "#{user["jobTitle"]}"
  puts "---"
end
