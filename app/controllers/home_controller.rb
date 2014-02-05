class HomeController < ApplicationController
  def index
    @users = User.all
    @filings = Filing.all
    
  end
end
