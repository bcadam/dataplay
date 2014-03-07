# == Schema Information
#
# Table name: filings
#
#  id             :integer          not null, primary key
#  company_id     :integer
#  title          :string(255)
#  url            :string(255)
#  links          :string(255)
#  summary        :string(255)
#  updated        :date
#  categories     :string(255)
#  file_id        :string(255)
#  cik            :string(255)
#  filingtext     :text
#  stockticker    :string(255)
#  footnote       :text
#  periodofreport :date
#

class Filing < ActiveRecord::Base
	
	belongs_to :company

end
