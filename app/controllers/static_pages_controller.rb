class StaticPagesController < ApplicationController
  helper_method :course_user_count
  include Yelp::V2::Search::Request
  def home
    
  	client = Yelp::Client.new

     request = BoundingBox.new(
             :term => "sports",
             :sw_latitude =>  37.757126,
             :sw_longitude => 	-122.39860799999997,
             :ne_latitude => 37.7659499,
             :ne_longitude => -122.43531000000002,
             :category => ['sportsbars'],
             :limit => 5)
 	 response = client.search(request)

     puts response.to_json

     @users = User.all
     @hash = Gmaps4rails.build_markers(@users) do |user, marker|
       marker.lat user.latitude
       marker.lng user.longitude
     end 
     directions = GoogleDirections.new("1550 Bryant Street, San Francisco, CA United States", "2294 15th Street, San Francisco, CA United States")
     drive_time_in_minutes = directions.drive_time_in_minutes
     puts drive_time_in_minutes
  end

  def help
  end
end
