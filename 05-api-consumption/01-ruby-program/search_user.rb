require "json"
require "rest-client"

puts "What is the name of the user you're looking for? (e.g. Bob Dylan)"
name = gets.chomp # asks user to type something in the Terminal
name = name.split(" ")
puts "Ok got it! Let's search for that person..."

# TODO: your code goes here
token = "18afcfb8-697b-4742-b726-418269485cee"
headers = {"Authorization" => "Lucca application=#{token}"}
url = "https://wagon.ilucca-demo.net/api/v3/users"

response = RestClient.get(url, "params" => {"fields" => "firstName,lastName,department,jobTitle,mail","lastName" => "#{name[1]}","firstName" => "#{name[0]}"}, "Authorization" => "Lucca application=#{token}")

users = JSON.parse(response.body)
user = users["data"]["items"][0]

puts "#{user["firstName"]} #{user["lastName"]} (#{user["mail"]})"
puts "#{user["jobTitle"]}"
puts "For #{user["department"]["name"]}"
