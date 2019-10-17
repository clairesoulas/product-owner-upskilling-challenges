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
    name = params["name"].upcase
    p name
    #param = (city != nil) || (category != nil) || (name != nil)
   # user_param = []
    #if city != nil
     # user_param << city
    #elsif category != nil
    #  user_param << category
    #elsif name != nil
    #  user_param << name
    #else
    #end

    query = "SELECT * FROM activities"

    if (city != nil && category != nil && name != nil)
      activities = DB.execute("#{query} WHERE city = \"#{city}\" AND category = \"#{category}\" AND UPPER(name) LIKE \"%#{name}%\";")
    elsif name != nil
      activities = DB.execute("#{query} WHERE UPPER(name) LIKE \"%#{name}%\";")
    elsif category != nil
      activities = DB.execute("#{query} WHERE category = \"#{category}\";")
    elsif city != nil
      activities = DB.execute("#{query} WHERE category = \"#{city}\";")
    else
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
