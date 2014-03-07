class ApiController < ApplicationController

def index
	@companies = Company.all
	@filings = Filing.all
	
	@result = @companies
	
	render xml: @result
	
end

def company
	if params[:cikhold] != nil
	@companies = Company.find_by("cik = ?", params[:cikhold])
	else
	@companies = Company.all
	end

	render xml: @companies
end

def filing
	@filing = Filing.pluck( :title, :file_id, :updated)

	render xml: @filing
end


end
