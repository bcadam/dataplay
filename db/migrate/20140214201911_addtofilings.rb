class Addtofilings < ActiveRecord::Migration
  def change
  	add_column :filings, :filingtext, :text
  	add_column :filings, :stockticker, :string
  	add_column :filings, :footnote, :text
  	add_column :filings, :periodofreport, :date
  end
end
