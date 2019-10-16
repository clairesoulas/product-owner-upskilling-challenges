require "json"
require "rest-client"

require "sinatra"
require "sinatra/link_header"
require "sinatra/reloader" if development?

enable :static

get "/" do
  url = "https://team-building-api.cleverapps.io/v2/activities"
  response = RestClient.get(url, "params"=>{"city"=>"#{params["location"]}"})
  activities = JSON.parse(response.body)

  @activities = activities["activities"]
  erb :index
end

get "/activities/:activity_id" do
  url = "https://team-building-api.cleverapps.io/v2/activities/#{params["activity_id"]}"
  response = RestClient.get(url)
  activities = JSON.parse(response.body)

  @activity = activities["activity"]
  erb :show
end

post "/" do
  url = "https://team-building-api.cleverapps.io/v2/activities"
  response = RestClient.get(url, "params" => {"search" => "#{params[:name]}", "category" => "#{params[:categories]}"})
  activities = JSON.parse(response.body)

  @activities = activities["activities"]

  erb :index
end
