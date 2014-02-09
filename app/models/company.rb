# == Schema Information
#
# Table name: companies
#
#  id       :integer          not null, primary key
#  name     :string(255)
#  cik      :string(255)
#  industry :string(255)
#

class Company < ActiveRecord::Base

	has_many :filings, class_name: "Filing", foreign_key: "cik"

                          
end

