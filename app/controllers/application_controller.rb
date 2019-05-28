class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def hello
    render html: "hello, world!"
  end
  
  before_action :set_categories_and_locations

  def set_categories_and_locations
    @categories =  Category.all
    @locations = Location.all
  end
  
  include UsersHelper
  include SessionsHelper
  
end
