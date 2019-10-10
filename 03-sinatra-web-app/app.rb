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
      "price" => 20, #Integer
      "photo_url" => "https://cdn.pixabay.com/photo/2018/02/12/22/37/mask-3149305__340.jpg"
    },
    {
      "name" => "Escape game", #String
      "category" => "Adventure", #String
      "city" => "Nantes", #String
      "duration" => 75, #Integer
      "participants" => 6, #Integer
      "price" => 20, #Integer
      "photo_url" => "https://cdn.pixabay.com/photo/2016/01/22/11/50/live-escape-game-1155620__340.jpg"
    },
    {
      "name" => "Stage de survie", #String
      "category" => "Adventure", #String
      "city" => "La forêt", #String
      "duration" => 180, #Integer
      "participants" => 6, #Integer
      "price" => 150, #Integer
      "photo_url" => "https://cdn.pixabay.com/photo/2015/09/09/16/05/forest-931706_960_720.jpg"
    }
  ]

  erb :index
end
