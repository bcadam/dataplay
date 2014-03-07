class AddIdtoCompany < ActiveRecord::Migration
  def change
    add_column :companies, :filing_id, :integer
  end
end
