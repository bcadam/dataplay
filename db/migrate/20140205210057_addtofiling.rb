class Addtofiling < ActiveRecord::Migration
  def change
  	add_column :filings, :cik, :string
  end
end
