require "json"
require "rest-client"

require "sinatra"
require "sinatra/link_header"
require "sinatra/reloader" if development?

enable :static

get "/" do
  url = "https://team-building-api.cleverapps.io/v2/activities"
  puts "#{url}"
  response = RestClient.get(url)
  activities = JSON.parse(response.body)

  @activities = activities["activities"]# TODO: retrieve all the activities from the API
  erb :index
end
