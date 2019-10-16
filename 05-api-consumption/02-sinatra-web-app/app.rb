require "json"
require "rest-client"

require "sinatra"
require "sinatra/link_header"
require "sinatra/reloader" if development?

enable :static

get "/" do
  # Get all activites, and retrieve categories
  url = "https://team-building-api.cleverapps.io/v2/activities"
  response = RestClient.get(url)
  all_activities = JSON.parse(response.body)

  all_activities = all_activities["activities"]
  @categories=[]

  all_activities.each do |activity|
    @categories << activity["category"]
  end
  @categories=@categories.uniq

  url = "https://team-building-api.cleverapps.io/v2/activities"
  response = RestClient.get(url, "params"=>{"city"=> params["location"], "search" => "#{params[:name]}", "category" => "#{params[:category]}"})

  activities = JSON.parse(response.body)

  @selected_category = params[:category]

  # Input search is empty or reusing value provided by user
  if params[:name] == nil
    then params[:name] = ""
  end
  @name_searched = params[:name]

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
