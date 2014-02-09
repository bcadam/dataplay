class HomeController < ApplicationController

	

  def index
    @users = User.all
    @filings = Filing.all
    @companies = Company.all
    #@mostrecent = recent(@filings)
    @most_common_filings_graph = graph( get_common_elements(@filings, "categories") , "filingcanvas" , 500 , 400 )
  end

  def recent (passed_array)
  	count_array = Array.new()
  	count_array.push(passed_array.reverse.first)
  	count_array.push(passed_array.reverse.second)
  	count_array.push(passed_array.reverse.third)
  	count_array.push(passed_array.reverse.fourth)
  	count_array.push(passed_array.reverse.fifth)

    return count_array
  end
  
end
