# == Schema Information
#
# Table name: watch_lists
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  companycik :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class WatchList < ActiveRecord::Base
	belongs_to :user

	attr_accessible :name, :companycik, :user_id
	
end
