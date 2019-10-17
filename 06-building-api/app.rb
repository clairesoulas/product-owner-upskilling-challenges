require "sinatra"
require "sinatra/json"
require "sinatra/link_header"
require "sinatra/namespace"
require "sinatra/reloader" if development?

require "sqlite3"

enable :static

DB_PATH = File.join(__dir__, "db/team_building.sqlite")
DB      = SQLite3::Database.new(DB_PATH)
DB.results_as_hash = true

get "/" do
  json "name" => "Team Building API", "status" => "Running"
end

namespace "/v1" do
  get "/activities" do
    activities = DB.execute("SELECT * from activities;")
    json "activities" => activities
  end
  get "/activities/:activity_id" do
    activity = DB.execute("SELECT * from activities WHERE id = #{params[:activity_id]};")
    json "activity" => activity
  end
end

namespace "/v2" do
  #Get all activities with filter (city as for now)
  get "/activities" do
    #Retrieve parameters
    city = params["city"]
    category = params["category"]
    #param = (city != nil) || (category != nil)

    if (city != nil && category != nil)
      activities = DB.execute("SELECT * FROM activities WHERE city = \"#{city}\" AND category = \"#{category}\";")
    elsif category != nil
      activities = DB.execute("SELECT * FROM activities WHERE category = \"#{category}\";")
    elsif city != nil
      activities = DB.execute("SELECT * FROM activities WHERE category = \"#{city}\";")
    else
      activities = DB.execute("SELECT * from activities;")
    end
    json "activities" => activities
  end
  #Get activity by id
  get "/activities/:activity_id" do
    activity = DB.execute("SELECT * from activities WHERE id = #{params[:activity_id]};")
    json "activity" => activity
  end
end

namespace "/doc" do
  get { erb :"doc/index" }

  namespace "/v1" do
    get "/activities" do
      erb :"doc/v1/activities"
    end
  end

  namespace "/v2" do
    get "/activities" do
      erb :"doc/v2/activities"
    end
  end
end
