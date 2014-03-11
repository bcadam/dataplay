class HomeController < ApplicationController

	

  def index
    #@users = User.all
    @filings = Filing.all
    #@companies = Company.all
    
    @most_common_filings_graph = graph( get_common_elements(@filings, "categories") , "filingcanvas" , 500 , 400 )
  end

  
  
end
