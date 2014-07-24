class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  helper_method :course_user_count
  include Yelp::V2::Search::Request

   def search
     client = Yelp::Client.new

     request = GeoPoint.new(
                 :term => 'thai',
                 :category_filter => 'food,restaurants',
                 :limit => 20,
                 :radius_filter => 8047,
                 :latitude => params[:latitude],
                 :longitude => params[:longitude])
     response = client.search(request)

     puts response
   end
end
