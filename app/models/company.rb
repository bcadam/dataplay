# == Schema Information
#
# Table name: companies
#
#  id        :integer          not null, primary key
#  name      :string(255)
#  cik       :string(255)
#  industry  :string(255)
#  filing_id :integer
#

class Company < ActiveRecord::Base

	has_many :filings, class_name: "Filing", foreign_key: "file_id"
        
end

