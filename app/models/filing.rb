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
#  updated        :datetime
#  categories     :string(255)
#  file_id        :string(255)
#  file_serial    :string(255)
#  cik            :string(255)
#  filingtext     :text
#  stockticker    :string(255)
#  footnote       :text
#  periodofreport :date
#  irsnumber      :string(255)
#

class Filing < ActiveRecord::Base
	attr_accessible :file_serial, :cik, :title, :url, :updated, :file_id, :filingtext

	belongs_to :company

	

end
