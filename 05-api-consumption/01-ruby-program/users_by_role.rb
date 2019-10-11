require "json"
require "rest-client"

puts "What is the role of the users you're looking for? (e.g. Figgo - Manager)"
role_name = gets.chomp # asks user to type something in the Terminal

puts "Ok got it! Let's search for the users..."

# TODO: your code goes here

token = "18afcfb8-697b-4742-b726-418269485cee"
headers = {"Authorization" => "Lucca application=#{token}"}
url = "https://wagon.ilucca-demo.net/api/v3/roles"

response = RestClient.get(url, "params" => {"fields" => "Name,UsersCount,Users","Name" => "like,#{role_name}"}, "Authorization" => "Lucca application=#{token}")

users_of_role = JSON.parse(response.body)

count = users_of_role["data"]["items"][0]["usersCount"]

puts "Total: #{count} users found"
