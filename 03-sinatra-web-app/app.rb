require "sinatra"
require "sinatra/link_header"
require "sinatra/reloader" if development?

enable :static

get "/" do
  @activities = [
    # TODO: gather a few activities
    {
      "name" => "Atelier theatre", #String
      "category" => "Cultural", #String
      "city" => "Nantes", #String
      "duration" => 120, #Integer
      "participants" => 12, #Integer
      "price" => 20 #Integer
    },
    {
      "name" => "Escape game", #String
      "category" => "Adventure", #String
      "city" => "Nantes", #String
      "duration" => 75, #Integer
      "participants" => 6, #Integer
      "price" => 20 #Integer
    },
    {
      "name" => "Stage de survie", #String
      "category" => "Adventure", #String
      "city" => "La forêt", #String
      "duration" => 180, #Integer
      "participants" => 6, #Integer
      "price" => 150 #Integer
    }
  ]

  erb :index
end
