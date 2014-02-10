class ApiController < ApplicationController

def index
	@companies = Company.all
	@filings = Filing.all
	
	@result = @companies
	
	render xml: @result
	
end

def company
	@companies = Company.pluck(:name)

	render xml: @companies
end

def filing
	@filing = Filing.pluck( :title, :file_id, :updated)

	render xml: @filing
end


end
