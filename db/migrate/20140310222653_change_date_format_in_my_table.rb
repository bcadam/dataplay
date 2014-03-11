class ChangeDateFormatInMyTable < ActiveRecord::Migration
  def up
   change_column :filings, :updated, :datetime
  end

  def down
   change_column :filings, :updated, :date
  end
end