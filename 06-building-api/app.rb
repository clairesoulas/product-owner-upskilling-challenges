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
    # Retrieve parameters & check if there are any
    city = params["city"]
    category = params["category"]
    name = params["name"]

    params = (city != nil) || (category != nil) || (name != nil)
    user_params = []

    if city != nil
     user_params << "city = \"#{city}\""
    end
    if category != nil
      user_params << "category = \"#{category}\""
    end
    if name != nil
      user_params << "UPPER(name) LIKE \"%#{name.upcase}%\""
    end

    query = "SELECT * FROM activities"

    if (params == false)
      activities = DB.execute("#{query};")
    else
      query = query + " WHERE " + user_params.join(" AND ")
      activities = DB.execute("#{query};")
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
