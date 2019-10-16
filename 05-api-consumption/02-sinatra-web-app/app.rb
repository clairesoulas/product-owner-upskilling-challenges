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

  @activities = activities["activities"]
  erb :index
end

get "/:activity_id" do
  #activity_id = "25"
  url = "https://team-building-api.cleverapps.io/v2/activities/#{params["activity_id"]}"
  puts "#{url}"
  response = RestClient.get(url)
  activities = JSON.parse(response.body)

  @activities = activities["activities"]
  #erb :index
end
